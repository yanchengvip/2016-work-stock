class UserAddressesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new, :create, :provinces, :cities, :counties, :map, :pcc]
  skip_before_filter :verify_authenticity_token, only:[:destroy]
  skip_before_filter :set_area, only: [:new, :create, :provinces, :cities, :counties,:pcc]
  before_filter :verify_redis,only: [:update,:verify]
  before_filter :set_address, only: [:show, :update, :destroy, :defadd, :edit, :depot_msg, :store_edit, :verify]
  before_filter :authority_verify!, only: [:show, :update, :destroy, :defadd, :edit]

  # skip_before_filter :give_verify_bag,only: [:update]

  def index
  end

  def show
  end

  def new
    if !current_user
      redirect_to sign_in_path
    elsif current_user.addresses.length != 0
      redirect_to :back, flash: {notice: '已经存在用户地址'}
    else
      @address = UserAddress.new
    end
  end

  def edit
    provinces = Province.all.order('ProvinceNo ASC')
    cities = City.where('ProvinceID = ?',provinces.find_by(ProvinceName: @address.Province).try(:ID))
    counties = County.where('CityID = ?',cities.find_by(CityName: @address.City).try(:ID))

    @provinces = provinces.map{|x|[x.ProvinceName,{'data-id':x.ID}]}.insert(0,['',{'data-id':''}])
    @cities = cities.map{|x|[x.CityName,{'data-id':x.ID}]}.insert(0,['',{'data-id':''}])
    @counties = counties.map{|x|[x.CountyName,{'data-id':x.ID}]}.insert(0,['',{'data-id':''}])
  end

  def create

    if from_app? and current_user.addresses.count !=0
      render json: {status: 'error', message: '已经存在用户地址'} and return
    end

    address = nil
    ActiveRecord::Base.transaction do
      UserAddress.where(UserID: current_user.ID).update_all(IsDefault: false)
      address = current_user.addresses.create(address_params.merge(IsDefault: true))
    end

    #change by lzh
    respond_to do |format|
      if address

        # change by lzh
        county = County.joins("left join Cities c on c.ID = Counties.CityID left join Provinces p on p.ID = c.ProvinceID")
                     .where("Counties.CountyName = ? and c.CityName = ? and p.ProvinceName = ?", current_user.addresses.first.County, current_user.addresses.first.City, current_user.addresses.first.Province)
                     .first

        county_id = session[:county_id] = cookies.permanent[:county_id] = county.ID
        session[:county_name] = cookies.permanent[:county_name] = county.CountyName
        session[:company_id] = cookies.permanent[:company_id] = county.city.CompanyID
        session[:city_id] = cookies.permanent[:city_id] = county.city.ID
        session[:depot_ids] = cookies.permanent[:depot_ids] = DepotSendCounty.get_depots_by( county_id )
        session[:last_update] = Time.now
        # change by lzh

        # city = City.joins("left join Provinces p on p.ID = Cities.ProvinceID").where("Cities.CityName = ? and p.ProvinceName = ?", address.City, address.Province ).first
        # current_user.update_attribute(:CompanyID, city.CompanyID)



        if params[:from_id].present?
          # format.html{ redirect_to address_users_path(from_id: params[:from_id]), flash: {success: '新建成功'} }
          format.html{ redirect_to store_edit_user_address_path, flash: {success: '新建成功'} }
          format.json{ render json: {status: 'ok' } }
        else
          if from_mobile?
            # format.html{ redirect_to address_users_path, flash: {success: '新建成功'} }
            format.html{ redirect_to store_edit_user_address_path, flash: {success: '新建成功'} }
            format.json{ render json: {status: 'ok' } }
          else
            # format.html{ redirect_to :back, flash: {success: '新建成功'} }
            format.html{ redirect_to :back, flash: {success: '新建成功'} }
            format.json{ render json: {status: 'ok' } }
          end
        end
      else
        # format.html{redirect_to :back, flash: {error: address.errors.full_messages.first || '新建失败'}}
        format.html{redirect_to :back, flash: {error: address.errors.full_messages.first || '新建失败'}}
        format.json{render json: {status: 'error'}}
      end
    end
    #change by lzh

    # if address
    #   if params[:from_id].present?
    #     redirect_to address_users_path(from_id: params[:from_id]), flash: {success: '新建成功'}
    #   else
    #     if from_mobile?
    #       redirect_to address_users_path, flash: {success: '新建成功'}
    #     else
    #       redirect_to :back, flash: {success: '新建成功'}
    #     end
    #   end
    # else
    #   redirect_to :back, flash: {error: address.errors.full_messages.first || '新建失败'}
    # end

  end

  def update
    # change by lzh
    # redirect_to(:back, flash: {error: '审核中的地址不可修改'}) and return if (store_info = @address.store_information) and store_info.Status.in?([1])
    if (store_info = @address.store_information) and store_info.Status.in?([1])
      respond_to do |format|
        format.html {redirect_to(:back, flash: {error: '审核中的地址不可修改'}) and return}
        format.json {render json: {status: 'error', message: '审核中的地址不可修改'} and return }
      end
    end
    # redirect_to(:back, flash: {error: '审核中的地址不可修改'}) and return if (store_info = @address.store_information) and store_info.Status.in?([1])

    # redirect_to(:back, flash: {error: '认证及审核中的地址不可修改'}) and return if (store_info = @address.store_information) and store_info.Status.in?([1, 2])
    # change by lzh
    store_info = @address.store_information
    if store_info && store_info.Status == 2 ||  ( store_info && store_info.Status == 0 )

      $redis.del("#{current_user.ID}#{cookies[:county_id]}Status")

      @address.update_attributes(address_params)

      respond_to do |format|
        format.html {redirect_to(store_edit_user_address_path, flash: {success: '修改认证中的地址需要重新认证，是否修改？'})}
        format.json {render json: {status: 'ok', message: '修改成功'}}
      end

    elsif store_info.nil?
      # city = City.joins("left join Provinces p on p.ID = Cities.ProvinceID").where("Cities.CityName = ? and p.ProvinceName = ?", @address.City, @address.Province ).first
      #
      # current_user.update_attribute(:CompanyID, city.CompanyID)
      @address.update_attributes(address_params)

      # change by lzh
      respond_to do |format|
        format.html {redirect_to(address_users_path, flash: {success: '修改成功'})}
        format.json {render json: {status: 'ok', message: '修改成功'}}
      end
      # redirect_to(store_edit_user_address_path, flash: {success: '修改成功'})
      #change by lzh
    else
      respond_to do |format|
        format.html {redirect_to(address_users_path, flash: {error: '修改失败'})}
        format.json {render json: {status: 'error', message: '修改失败'}}
      end
    end
  end

  def destroy
    if current_user.addresses.count == 1
      redirect_to(address_users_path, flash: {error: '唯一地址不可以删除'}) and return
    elsif (store_info = @address.store_information)
      redirect_to(address_users_path, flash: {error: '已认证的地址不可以删除'}) and return if store_info.Status == 2
      redirect_to(address_users_path, flash: {error: '认证中的地址不可以删除'}) and return if store_info.Status == 1
    end
    if @address.update_attribute(:IsDeleted, true)
      address = current_user.addresses.first
      address.update_attribute(:IsDefault, true)
      redirect_to(address_users_path, flash: {success: '删除成功'}) and return
    else
      respond_to do |format|
        format.html {redirect_to(address_users_path, flash: {error: '删除失败'})}
        format.json {render json: {status: 'error', message: '删除失败'}}
      end
    end
  end

  def defadd
    status = false
    ActiveRecord::Base.transaction do
      UserAddress.where(UserID: current_user.ID).update_all(IsDefault: false)
      status = @address.reload.update_attributes(IsDefault: true)
    end
    respond_to do |format|
      if status
        format.html{redirect_to(:back, flash: {success: '设置成功'})}
        format.json{render json: {status: 'ok'}}
      else
        format.html{redirect_to(:back, flash: {error: '设置失败'})}
        format.json{render json: {status: 'error'}}
      end
    end
  end

  def store_edit

    if ( store_info = @address.store_information ) && store_info.Status == 2
      store_info.delete
    end
    # redirect_to(address_users_path, flash: {success: '认证中无法修改'}) if (store_info = @address.store_information) and store_info.Status == 1
  end

  def verify

    @address.update_attributes(address_params)
    if @address.store_information
      redirect_to(address_users_path, flash: {success: '认证中无法修改'}) and return if @address.store_information.Status == 1
      @address.store_information.update_attributes(ReceiveName: @address.ShipName, Tel: @address.Mobile, FaceName: @address.FaceName, Address: @address.Detailedaddress, Province: @address.Province,
                                                   City: @address.City, Area: @address.County, FacePhotoCoverNiuID: params[:FacePhotoCover], LicencePhotoCoverNiuID: params[:LicencePhotoCover],
                                                   StoreType: params[:StoreType], Nearby: params[:Nearby], StoreArea: params[:StoreArea], IsChain: params[:IsChain],RegisterPhone: current_user.Phone)
    else
      StoreInformation.create(ReceiveName: @address.ShipName, Tel: @address.Mobile, FaceName: @address.FaceName, Address: @address.Detailedaddress, Province: @address.Province, City: @address.City,
                              Area: @address.County, FacePhotoCoverNiuID: params[:FacePhotoCover], LicencePhotoCoverNiuID: params[:LicencePhotoCover], Status: 1, UserAddressID: @address.ID,
                              StoreType: params[:StoreType], Nearby: params[:Nearby], StoreArea: params[:StoreArea], IsChain: params[:IsChain],RegisterPhone: current_user.Phone)
    end
    redirect_to address_users_path, flash: {success: '操作成功'}
  end

  def map
  end

  def pcc
    @provinces = Province.includes(:cities => [:counties]).order('ProvinceNo ASC')
  end

  def provinces
    @provinces = Province.all.order('ProvinceNo ASC')
  end

  def cities
    @cities = City.where('ProvinceID = ?',params[:provinceID])
  end

  def counties
    @counties = County.where('CityID = ?',params[:cityID])
  end

  def depot_msg
  end

  def certified
  end

  #
  def return_verify_status
    # @address = UserAddress.find_by(UserID: current_user.ID)
    # if @address.store_information
    #   @status=@address.store_information.Status
    # else
    #   @status= 3
    # end

    @addresses = UserAddress.where(UserID: current_user.ID)

    @status = 3
    @addresses.each do |address|
      if address.store_information && address.store_information.Status == 2
        @status = 2
        break
      end
    end

    # if !$redis.get("#{current_user.ID}Status").nil?
    #   @status = 2
    # else
    #   @address = UserAddress.find_by(UserID: current_user.ID)
    #   if @address.store_information
    #     @status=@address.store_information.Status
    #   else
    #     @status= 3
    #   end
    # end
  end

  private
  def set_address
    @address = UserAddress.find_by(ID: params[:id])
  end

  def address_params
    params.require(:user_address).permit(:Supplements,:Longitude,:Latitude,:Detailedaddress, :Province, :City, :County, :CountyID, :ShipName, :Mobile, :IsDefault, :ZipCode, :FaceName)
  end

  def authority_verify!
    if @address != nil && @address.UserID != current_user.ID
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render json: {status: 'error', message: '没有权限'} }
      end
    end
  end

end
