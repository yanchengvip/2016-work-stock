class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include SessionsHelper

  before_filter :redirect_to_home, unless: :from_mobile?
  before_filter :store_location
  #before_filter :check_area, unless: :from_app?
  before_filter :authenticate_user!, if: :from_mobile?
  before_filter :set_area, if: :from_mobile?

  layout :set_layout
  helper_method :from_mobile?, :from_app?

  # change by lzh,给予注册礼包
  # before_filter 'give_verify_bag'
  # change by lzh

  def authenticate_user!
    if !sign_in?
      respond_to do |format|
        format.html { redirect_to sign_in_path }
        format.json { render json: {status: 'error', error_code: 'IsNotVerified'}}
      end
    else
      if current_user.addresses.length == 0
        respond_to do |format|
          format.html { redirect_to new_user_address_path }
          format.json { render json: {status: 'error', error_code: 'IsNotVerified'}}
        end
      end
    end
  end

  # change by lzh
  def verify_redis
    if $redis.get("#{current_user.ID}#{cookies[:county_id]}Status")
      $redis.del("#{current_user.ID}#{cookies[:county_id]}Status")
    end
  end
  # change by lzh

  def redirect_to_home
    redirect_to root_path if request.get? and request.fullpath != "/" and request.fullpath !~ /common|reports/ and request.format != 'json'
  end

  def store_location
    session[:return_to] = request.fullpath if request.get? and request.fullpath !~ /sign_.*|sessions|registrations|passwords|auth|registerxy|login|token|location/ and request.format != 'json'
  end

  def check_area
    if from_mobile? and (!cookies[:company_id] or !cookies[:county_id] or !cookies[:city_id])
      redirect_to location_path
    end if request.format != 'json'
  end

  def set_area
    if from_app?
      set_area_info_app
    else
      set_area_info_web
    end
  end

  def set_area_info_web
    if !cookies[:company_id] or !cookies[:county_id] or !cookies[:city_id]
      addresses = current_user.addresses.to_a
      if addresses.size == 1
        address = addresses.first
        county = address.county
        session[:county_id] = cookies.permanent[:county_id] = county.ID
        session[:county_name] = cookies.permanent[:county_name] = county.CountyName
        session[:city_id] = cookies.permanent[:city_id] = county.CityID
        session[:company_id] = cookies.permanent[:company_id] = address.CompanyID
        #get_depots_by传入参数不可以是session[:county_id],因为get_depots_by函23456数定义在模型文件，session参数传过去还是session并非只是一个值而已
        session[:depot_ids] = DepotSendCounty.get_depots_by(county.id)
        session[:last_update] = Time.now
      else
        redirect_to location_path and return
      end

    else
      # change on 11-14
      if current_user.addresses.where(CountyID: cookies[:county_id]).size == 0
        addresses = current_user.addresses.to_a
        if addresses.size == 1
          address = addresses.first
          county = address.county
          session[:county_id] = cookies.permanent[:county_id] = county.ID
          session[:county_name] = cookies.permanent[:county_name] = county.CountyName
          session[:city_id] = cookies.permanent[:city_id] = county.CityID
          session[:company_id] = cookies.permanent[:company_id] = address.CompanyID
          #get_depots_by传入参数不可以是session[:county_id],因为get_depots_by函23456数定义在模型文件，session参数传过去还是session并非只是一个值而已
          session[:depot_ids] = DepotSendCounty.get_depots_by(county.ID)
          session[:last_update] = Time.now
        else
          redirect_to location_path and return
        end
      elsif session[:county_id] != cookies[:county_id] or !session[:last_update] or session[:last_update] < 5.minutes.ago
        session[:county_name] = cookies[:county_name]
        session[:county_id] = cookies[:county_id]
        session[:city_id] = cookies[:city_id]
        session[:company_id] = cookies[:company_id]
        session[:depot_ids] = DepotSendCounty.get_depots_by(cookies[:county_id])
        session[:last_update] = Time.now
      end
      # change on 11-14
    end
  end

  def set_area_info_app
    if session[:county_id] != params[:region][:county_id] or !session[:last_update] or session[:last_update] < 5.minutes.ago
      session[:company_id] = params[:region][:company_id]
      session[:city_id] = params[:region][:city_id]
      session[:county_id] = params[:region][:county_id]
      session[:depot_ids] = DepotSendCounty.get_depots_by(params[:region][:county_id])
      session[:last_update] = Time.now
    end if params[:region]
  end

  def redirect_back_or(default, flash=nil)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def from_mobile?
    # return true
    if Rails.env.production?
      (request.subdomain == 'm.jinhuobao') or (request.subdomain == 'm')
    else
      user_agent = request.env["HTTP_USER_AGENT"].to_s
      user_agent.present? && user_agent.downcase.include?("mobile") or user_agent.downcase.include?("android") or user_agent.downcase.include?("ipad") or user_agent.downcase.include?("jinhuobao")
    end
  end

  def from_app?
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"].downcase.include?("jinhuobao-api")
  end

=begin
  def set_area_info_web
    if session[:county_id] != cookies[:county_id] or !session[:last_update] or session[:last_update] < 5.minutes.ago
      session[:county_id] = cookies[:county_id]
      session[:depot_ids] = DepotSendCounty.get_depots_by(cookies[:county_id])
      session[:last_update] = Time.now
    end
  end
=end

  # change by lzh ,登录之后判断是否认证，认证通过之后给予认证礼包
  def give_verify_bag
    if current_user && $redis.get("#{current_user.ID}Verify_giftbags").nil?
      @address = UserAddress.find_by(UserID: current_user.ID)
      if @address
        if ( ( store_info = @address.store_information ) && store_info.Status == 2 )
          gift_bag = GiftBag.find_by(CompanyID: cookies[:company_id], State: 1, Status: 2,Type: 1)
          # gift_bag.coupons.each do |coupon|
          #   count = coupon.CouponCount.to_i > 0 ? coupon.CouponCount : 1
          #   UserCoupon.create(UsersID: current_user.ID,Price: coupon.CouponPrice, CouponDiscount: coupon.CouponDiscount, UseMoney: coupon.ActivityPrice, Status: 1,
          #                     StartDate: Date.today, EndDate: Date.today + coupon.CouponDays - 1.second, Source: 0, Cause: '认证礼包',
          #                     ProvideCount: count, CurrentCount: count, CouponID: coupon.ID)
          # end if gift_bag
          $redis.set("#{current_user.ID}Verify_giftbags",true)
        end
      end
    end
  end
  # change by lzh

  private
  def set_layout
    from_mobile? ? 'mobile' : 'application'
  end
end
