class ProductsController < ApplicationController
  before_filter :set_product, only: [:show, :add_favorite, :del_favorite]
  skip_before_filter :authenticate_user!,except: [:barcode_scanner,:barcode_histories]

  def index
    conditions = ["Products.State = 2 and Products.Type not in (2,4,5) and (ActivityBeginTime is null or (ActivityBeginTime <= ? and ActivityEndTime > ?))"]
    values = [Time.now, Time.now]
    joins = ["inner join ProductInfoes pi on Products.ProductInfoID = pi.ID"]
    if params[:q].to_s.strip.present?
      conditions << "pi.Name like ?"
      values << "#{params[:q].to_s.gsub(' ','').gsub(//,'%')}"
      KeywordSearchHistory.create(UserID: current_user.id,KeyWordName: params[:q])
    end
    if params[:fid].present? and (group = ProductGroup.find_by(ID: params[:fid])).present?
      conditions << "pi.ProductGroupsID in (?)"
      values << group.second_groups.map(&:ID)
    end
    if params[:sid].present? and (@group = ProductGroup.find_by(ID: params[:sid])).present?
      conditions << "pi.ProductGroupsID = ?"
      values << @group.ID
    end
    if params[:brand_id].present?
      t=params[:brand_id].split(',')
      conditions << "pi.ProductBrandID in (?)"
      values << t
      # conditions << "pi.ProductBrandID = ?"
      # values << params[:brand_id]
    end
    if params[:company_id].present?
      conditions << "Products.CompanyID = ?"
      values << params[:company_id]
    end
    if (tags = params[:tags].to_s.split(',')).present?
      conditions << "ptg1.TagID = ?"
      values << tags.first
      joins << "inner join ProductTagGroups ptg1 on ptg1.ProductInfoID = pi.ID"
      if tags.size > 1
        conditions << "ptg2.TagID = ?"
        values << tags.last
        joins << "inner join ProductTagGroups ptg2 on ptg2.ProductInfoID = pi.ID"
      end
    end

    if Company.need_stock?(session[:company_id])
      joins << "left join DepotProductStocks dps on dps.ProductID = Products.ID"
      conditions << "dps.DepotID in (?) and dps.State = 2"
      values << session[:depot_ids]
    else
      joins << "left join FrameworkCompanies fc on fc.ID = products.CompanyID"
      conditions << "products.SellState = 2 and (fc.ThirdType = 3 or fc.ID = ?)"
      values << session[:company_id]
    end

    # 有关排序
    if Company.need_stock?(session[:company_id])
      sort = params[:sort] == "desc" ? "Stock desc, SaleCountBySevenDays desc" : "Stock desc, Name"
      _select = "Products.*, if(dps.Stock + dps.PreSaleQuantity > 0, 1, 0) as Stock"
    else
      sort = params[:sort] == "desc" ? "SaleCountBySevenDays desc" : "Name"
      _select = "Products.*"
    end
    @products = Product.select(_select).includes(:company, :product_info, :group_products => [:sub_product => [:product_info]])
                    .joins(joins.join(' ')).where(conditions.join(' and '), *values)
                    .order(sort).page(params[:page]).per(20)

    product_ids = @products.map(&:ID)
    # 运营推广商品
    if (!params[:page] or params[:page].to_i == 1) and params[:sort].blank? and params[:brand_id].blank?
      @recommend_products = Product.joins("right join recommend_config_products rcp on rcp.ProductID = products.ID
                                          right join recommend_configs rc on rc.ID = rcp.RecommendConfigID")
                                  .includes(:company, :product_info, :group_products => [:sub_product => [:product_info]])
                                  .where("products.State = 2 and rc.CompanyID = ? and rc.ProductGroupID = ? and rc.BeginDate < ? and rc.EndDate > ?
                                          and (ActivityBeginTime is null or (ActivityBeginTime <= ? and ActivityEndTime > ?))",
                                          session[:company_id], params[:sid], Time.now, Time.now, Time.now, Time.now).order("rcp.Sort")
      product_ids |= @recommend_products.map(&:id)
    end

    @stocks = DepotProductStock.stocks_for(product_ids, session[:depot_ids])
  end

  def list
    redirect_to(products_path) and return if !from_mobile?
    params[:type] ||= 'group'
    if params[:type] == 'group'
      # 走的是这里
      @left_list = ProductGroup.first_groups(session[:city_id]).to_a
    else
      @left_list = ProductBrand.order('BrandCode').to_a
    end

    # params[:type] ||= 'group'
    # if params[:type] == 'group'
    #   if params[:fromCart] == 'true'
    #     @left_list =ProductGroup.joins("left join CompanyProductGroups cpg on cpg.ProductGroupID = ProductGroups.ID ").where("Level = 1 and State = 1 and CityID = ? and cpg.CompanyID = ? ",session[:city_id],'22294f4c-dacc-48d6-aba8-d6c8fbe8cf7e' ).order("OrderBy")
    #   else
    #     @left_list = ProductGroup.first_groups(session[:city_id]).to_a
    #   end
    #
    # else
    #   if params[:fromCart] == 'true'
    #     @left_list = ProductBrand.order('BrandCode').to_a
    #   else
    #     @left_list = ProductBrand.order('BrandCode').to_a
    #   end
    # end

  end

  def show
    @recommends = Product.show_recommends
  end

  def add_favorite
    if Enshrine.find_by(ProductID: @product.id, UserID: current_user.id)
      render json: {status: 'error', message: '该商品已存在收藏夹'}
    elsif current_user.enshrines.create(ProductID: @product.ID)
      render json: {status: 'ok'}
    else
      render json: {status: 'error', message: '操作失败'}
    end
  end

  def add_favorite_more
    if current_user.add_to_favorites(params[:ids])
      render json: {status: 'ok'}
    else
      render json: {status: 'error', message: '操作失败'}
    end
  end

  def del_favorite
    enshrine = Enshrine.find_by(ProductID: @product.id, UserID: current_user.id)
    if !enshrine or enshrine.destory
      render json: {status: 'ok'}
    else
      render json: {status: 'error', message: '操作失败'}
    end
  end

  def search
    @keywords = KeywordManagement.first
  end

  #change by lzh
  def return_product_bycode
    @products = Product.where(Code: params[:Code],CompanyID: session[:company_id])

    # @remote_products = Array.new
    # if @products.length == 0
    #   require 'json'
    #   uri = URI("http://api.jisuapi.com/barcode2/query?barcode=#{params[:Code]}&appkey=d10d68c2760ef143")
    #   response = Net::HTTP.get_response(uri)
    #
    #   data=response.body
    #   jsons=JSON.parse(data)
    #
    #   @remote_products=jsons['result']
    #   Rails::logger.info("----------------#{@remote_products}---------")
    # end


#     @product_brands = ProductBrand.joins("right join productgroup_brands pgb on pgb.ProductBrandID
# = productbrands.ID").where("pgb.ProductGroupID in (?)", @left_list.map(&:ID))

  end
  #change by lzh

  #根据左侧栏目实时返回对应品牌的接口
  def return_brand
    # params[:sid]='712ee928-b07f-4401-a8a2-cb94f0a9a417'
    @left_list = ProductGroup.where(ID: params[:sid])
    @product_brands = ProductBrand.joins("right join productgroup_brands pgb on pgb.ProductBrandID
= productbrands.ID").where("pgb.ProductGroupID in (?)", @left_list.map(&:ID))
  end

  #条码查询
  def barcode_scanner
    if params[:MoreThanOne].nil?
      @products = Product.includes(:product_info).where(Code: params[:Code])
      if @products.length > 1
        @products = Product.includes(:product_info).where(Code: params[:Code],CompanyID: session[:company_id])
      end
    else
      @product = Product.includes(:product_info).find_by(ID: params[:ID])
    end

    #在products表查找不到商品，就去查找productinfoes表
    # if @product.nil? && ( @products && @products.length == 0 )
    #   @products2 = @product = ProductInfo.find_by(Code: params[:Code],CompanyID: session[:company_id])
    # end

    #记录历史记录
    # @barcode_history = BarcodeHistory.create(ID: Time.now,UserID: current_user.id,Code: params[:Code])
    if params[:FromHistories] != "true"
      if !@product.nil?
        if params[:ID].nil?
          @barcode_history = BarcodeHistory.create(UserID: current_user.id,Code: params[:Code])
        else
          @barcode_history = BarcodeHistory.create(UserID: current_user.id,Code: params[:ID])
        end
      elsif @products && @products.length == 1
        @barcode_history = BarcodeHistory.create(UserID: current_user.id,Code: params[:Code])
      end
    end

  end


  #条码查询历史记录
  def barcode_histories

    # 查询的时候是根据商品的Code查询的，而对于一个码对应多个商品的情况，我们存入的Code反而是商品ID，所以报错
    @barcode_histories = BarcodeHistory.where(UserID: current_user.id,IsDeleted: false)

    @products = Product.joins("right join barcode_histories on Products.Code = barcode_histories.Code  or Products.ID = barcode_histories.Code
                              inner join frameworkcompanies on frameworkcompanies.ID = Products.CompanyID ")
                    .select('barcode_histories.CreateTime,barcode_histories.UserID,Products.ProductInfoID,Products.ID,Products.Name,Products.Specification,Products.ProductPrice,Products.Code,Products.ThirdType,frameworkcompanies.ThirdType')
                    .where("barcode_histories.UserID = ? and IsDeleted = false", current_user.id)
                    .order("barcode_histories.CreateTime DESC")

    # .where("Products.CompanyID = ? and barcode_histories.UserID = ?", session[:company_id],current_user.id)

  end

  #清空历史记录
  def destroy_histories
    @barcode_histories = BarcodeHistory.where(UserID: current_user.id)

    if @barcode_histories.update_all(IsDeleted: true)
      respond_to do |format|
        format.html { redirect_to barcode_histories_products_path }
        format.json { render json: {status: 'ok'} }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, flash: { error: current_user.errors.full_messages.first } }
        render json: {status: 'error', message: '操作失败'}
      end
    end

  end

  def destroy_search_histories
    @keyword_search_histories = current_user.keyword_search_histories
    if @keyword_search_histories.update_all(IsDeleted: true)
      render json: {status: 'ok'}
    else
      render json: {status: 'error', message: '操作失败'}
    end
  end

  private
  def set_product
    @product = Product.find_by(ID: params[:id])
  end

end
