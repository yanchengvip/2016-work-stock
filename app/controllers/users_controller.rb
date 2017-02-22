class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:favorites, :update_integral]
  skip_before_filter :verify_authenticity_token, only: [:update_integral]
  skip_before_filter :set_area, only: [:update_integral]

  # change by lzh
  before_filter :verify_redis,only: [:update_info,:update_password]
  # change by lzh


  def mine
  end

  def is_limit_buy
  end

  def orders
    condition = "OrderStatus is not null and OrderStatus not in (0, 6, 11)"
    if params.key?(:status)
      case params[:status].to_i
      when 0
        condition = "OrderStatus in (1,2,7,10)"
      when 1
        condition = "OrderStatus = 3"
      when 2
        condition = "OrderStatus in (4,5,8)"
      end
    end
    @orders = current_user.orders.includes(:order_score, :company, :order_products => [:product => :product_info]).where(condition).order("CreateTime desc").page(params[:page]).per(20)
  end

  def integral
  end

  def info
  end

  def update_info
    if current_user.update_attributes(Name: params[:Name], Mail: params[:Mail], BirthYear:params[:BirthYear], BirthMonth:params[:BirthMonth], BirthDay:params[:BirthDay])
      redirect_to :back, flash: {success: '修改成功'}
    else
      redirect_to :back, flash: {error: '修改失败'}
    end
  end

  def password
  end

  def update_password
    if current_user.authenticate(params[:user][:old_password])
      if current_user.update_attributes(Password: params[:user][:Password], password_confirmation: params[:user][:password_confirmation])
        respond_to do |format|
          format.html { redirect_to :back, flash: {success: '修改成功'} }
          format.json { render json: {status: 'ok'} }
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, flash: { error: current_user.errors.full_messages.first } }
          format.json { render json: {status: 'error', message: @user.errors.full_messages.first} }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, flash: {error: '密码不正确'} }
        format.json { render json: {status: 'error', message: '密码不正确'} }
      end
    end
  end

  def coupons
    @coupons = case params[:type].to_i
               when 0
                 current_user.unused_coupons(params[:page])
               when 1
                 current_user.used_coupons(params[:page])
               when 2
                 current_user.dated_coupons(params[:page])
               end
  end

  def coupons_rule
  end

  def exchange
  end

  def exchange_coupon
    status, message = current_user.exchange_coupon(params[:coupon_code])
    if status
      render json: {status: 'ok'}
    else
      render json: {status: 'error', message: message || '操作失败'}
    end
  end

  def favorites
    @enshrines = sign_in? ? current_user.enshrines.includes(:product => [:product_info]) : []
    redirect_to sign_in_path if !sign_in? and request.format == 'html'
  end

  def address
    @addresses = current_user.addresses.includes(:store_information)
    #current_user.addresses.where("DepotID is null or DepotID = ''").update_all("Province = null, City = null, County = null")

    if (@address = UserAddress.find_by(ID: params[:id], UserID: current_user.ID))
      provinces = Province.all.order('ProvinceNo ASC')
      cities = City.where('ProvinceID = ?',provinces.find_by(ProvinceName: @address.Province).try(:ID))
      counties = County.where('CityID = ?',cities.find_by(CityName: @address.City).try(:ID))

      @provinces = provinces.map{|x|[x.ProvinceName,{'data-id':x.ID}]}.insert(0,['',{'data-id':''}])
      @cities = cities.map{|x|[x.CityName,{'data-id':x.ID}]}.insert(0,['',{'data-id':''}])
      @counties = counties.map{|x|[x.CountyName,{'data-id':x.ID}]}.insert(0,['',{'data-id':''}])
    else
      @address = UserAddress.new
    end if !from_mobile?
  end

  def check_in
    if CheckIn.find_or_create_by(UserID: current_user.ID, CheckInDate: Date.today)
      render json: {status: 'ok', message: "签到成功"}
    end
  end

  def update_integral
    status = false
    ActiveRecord::Base.transaction do
      user = User.find_by(RememberToken: params[:auth_token]).lock!
      flag = true
=begin
      if params[:type].to_i == 0
        sub_flag = false
        addresses = user.addresses.joins(:store_information).where("storeinformations.Status = 2")
        order = Order.find_by(ID: params[:order_id])
        addresses.each do |address|
          if [address.Province, address.City, address.County].join(' ') + address.Detailedaddress == order.Address
            sub_flag = true
            break
          end
        end
        flag = sub_flag
      end
=end
      if flag
        delta_point = params[:delta_point].to_i
        user.increment_with_sql!(:Integral, delta_point)
        user.point_histories.create!(CurrentPoint: user.Integral, DeltaPoint: delta_point, Type: params[:type].to_i, OrderID: params[:order_id], CreateBy: params[:remark])
        user.notifications.create!(Content: "您有#{delta_point}积分到账", Type: 0, Remark: "导入收款成功新增积分#{delta_point}")
      end
      status = true
    end
    if status
      render json: {status: 'ok'}
    else
      render json: {status: 'ok', message: '操作失败'}
    end
  end

end
