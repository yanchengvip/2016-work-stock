class CouponsController < ApplicationController
  #skip_before_filter :authenticate_user!, except: [:mine, :collect]
  before_filter :set_coupon, only: [:products, :collect]


  def index
    @coupons = Coupon.can_collect_by_type(current_user, cookies[:city_id])
  end

  def universal
    # change by lzh
    # @coupons = Coupon.can_collect_universal(current_user, params[:company_id])
    if Company.find_by(ID: params[:company_id]).ThirdType == 0
      @coupons = Coupon.select("Coupons.*, if(uc.UsersID is null, 0, 1) has_collect").includes(:company)
                     .joins("left join UserCoupons uc on uc.CouponID = Coupons.ID and uc.UsersID = '#{current_user.try(:ID)}'")
                     .where("coupons.Usage = 1 and coupons.Status = 2 and coupons.CurrentCount < CouponCount and BeginTime < ? and EndTime > ? and (CouponType = 0 ) and (uc.ID is null or uc.Status = 1)", Time.now, Time.now )
                     .order("CouponPrice desc, EndTime asc, BeginTime asc")
    else
      @coupons = Coupon.can_collect_universal(current_user, params[:company_id])
    end

  end

  def mine
    order = Order.find_by(ID: params[:order_id])
    @usable_coupons, @unusable_coupons = current_user.coupons_by(order)
  end

  def products
    if @coupon.CouponType == 4
      @products = @coupon.products.select("Products.*, if(dps.Stock > 0, 1, 0) as Stock").includes(:product_info, :group_products => [:sub_product => [:product_info]])
                         .joins("left join DepotProductStocks dps on dps.ProductID = Products.ID").where("dps.DepotID in (?) and dps.State = 2", session[:depot_ids])
                         .page(params[:page]).per(20)
    elsif @coupon.CouponType == 1
      @products = Product.select("Products.*, if(dps.Stock > 0, 1, 0) as Stock").includes(:product_info)
                         .joins("left join DepotProductStocks dps on dps.ProductID = Products.ID")
                         .where("Products.State = 2 and Products.Type != 2 and Products.Type != 4 and Products.CompanyID = ?", @coupon.CompanyID)
                         .page(params[:page]).per(20)
    elsif @coupon.CouponType.in?([2,3])
      if @coupon.CouponType == 2
        @product_groups = @coupon.product_groups
        @product_brands = ProductBrand.joins("right join productgroup_brands pgb on pgb.ProductBrandID
= productbrands.ID").where("pgb.ProductGroupID in (?)", @product_groups.map(&:ID))
      else
        @product_brands = @coupon.product_brands
        @product_groups = ProductGroup.joins("right join productgroup_brands pgb on pgb.ProductGroupID = productgroups.ID").where("pgb.ProductBrandID in (?)", @product_brands.map(&:ID))
      end
      joins = ["inner join ProductInfoes pi on Products.ProductInfoID = pi.ID"]
      conditions = ["Products.State = 2 and Products.Type != 2 and Products.Type != 4 and Products.CompanyID = ?"]
      values = [@coupon.CompanyID]
      if params[:group_id].present?
        conditions << "pi.ProductGroupsID = ?"
        values << params[:group_id]
      end

      if params[:brand_id].present?
        # t=params[:brand_id]
        # conditions << "pi.ProductBrandID = ?"
        # values << t
        t=params[:brand_id].split(',')
        conditions << "pi.ProductBrandID in (?)"
        values << t
      end

      # #change by lzh
      # if params[:brand_id].present?
      #   conditions << "pi.ProductBrandID = ?"
      #   values << params[:brand_id]
      # end
      # #change by lzh

      joins << "left join DepotProductStocks dps on dps.ProductID = Products.ID"
      conditions << "dps.DepotID in (?) and dps.State = 2"
      values << session[:depot_ids]
      sort = params[:sort] == "desc" ? "desc" : "asc"
      @products = Product.select("Products.*, if(dps.Stock > 0, 1, 0) as Stock").includes(:product_info, :group_products => [:sub_product => [:product_info]])
                         .joins(joins.join(' ')).where(conditions.join(' and '), *values)
                         .order("ProductPrice #{sort}").page(params[:page]).per(20)
    end
  end

  def collect
    status, message = current_user.collect_coupon(@coupon)
    if status
      render json: {status: 'ok', data: {use_url: @coupon.use_url}}
    else
      render json: {status: 'error', message: message || '操作失败'}
    end
  end

  def sales
  end

  def sales_state
  end

  private
  def set_coupon
    @coupon = Coupon.find_by(ID: params[:id])
  end



end
