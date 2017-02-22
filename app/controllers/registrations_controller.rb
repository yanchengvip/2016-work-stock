class RegistrationsController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :set_area
  layout :set_layout

  def new
    @user = User.new
  end

  def new_tel
  end

  def create

    # change by lzh
    # session----params[:user][:Phone]
    # @user = User.new(user_params.merge(State: 1, CompanyID: cookies[:company_id],IsChain: params[:IsChain]))
    @user = User.new(user_params.merge(State: 1, IsChain: params[:IsChain]))
    # @user = User.new(user_params.merge(State: 1, CompanyID: cookies[:company_id]))
    # change by lzh

    if @user.save
      @user.addresses.create(user_params[:address].merge({IsDefault: 1, Mobile: user_params[:Phone]})) if user_params[:address]
      #2016-06-30 取消注册送优惠券
      # coupon = @user.coupons.create(Price: StockRandom.new_user_coupon, UseMoney: 1000, Status: 1, EndDate: Time.now + 3.days - 1.second, Source: 0)
      # Sms.clear_check_code(params[:user][:Phone])

      sign_in @user
      #if cookies[:share_code].present? and (user = User.find_by(ID: Base64.decode64(cookies[:share_code])))
        #user.success_invite(user_params[:Phone])
      #end
      respond_to do |format|

        #change by lzh
        session[:tel_param]=params[:user][:Phone]
        format.html { redirect_back_or store_edit_user_address_path }
        #change by lzh

        format.json { render json: {status: 'ok', data: { auth_token: @user.RememberToken }, return_to: '/addresses/new' || '/' } }
        # format.json { render json: {status: 'ok', return_to: session[:return_to] || '/'} }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, flash: {error: @user.errors.full_messages.first} }
        format.json { render json: {status: 'error', message: @user.errors.full_messages.first} }
      end
    end
  end

  def tel_login
    if (user = User.find_by(Phone: params[:tel].downcase))
      if Sms.valid?(params[:tel], params[:check_code])
        sign_in user
        respond_to do |format|
          format.html { redirect_back_or root_path }
          format.json { render json: {status: 'ok', data: { auth_token: user.RememberToken, is_login: true }, return_to:  session[:return_to] || '/' } }
          # format.json { render json: {status: 'ok', data: {auth_token: user.RememberToken}, return_to: session[:return_to] || '/'} }
        end
      else
        respond_to do |format|
          format.html { redirect_to(:back, flash: {error: '手机号或验证不正确'}) }
          format.json { render json: {status: 'error', message: '手机号或验证不正确', error_code: "TEL_CODE_NOT_MATCH"}}
        end
      end
    else
      # user = User.new(Phone: params[:tel], check_code: params[:check_code], State: 1, Type: 1, CompanyID: cookies[:company_id],IsChain: params[:IsChain])
      user = User.new(Phone: params[:tel], check_code: params[:check_code], State: 1, Type: 1,IsChain: params[:IsChain])
      # change by lzh
      # user = User.new(Phone: params[:tel], check_code: params[:check_code], State: 1, Type: 1, CompanyID: cookies[:company_id])
      # change by lzh
      if user.save
        sign_in user
        popup = PopupConfig.enabled(cookies[:city_id], 2).first
        if popup and (coupon = popup.coupon)
          user.coupons.create(Price: coupon.CouponPrice, Status: 1, Source: 0, UseMoney: coupon.ActivityPrice, StartDate: Date.today, EndDate: Date.today + coupon.CouponDays.days - 1.second, Cause: '注册送券', CouponID: coupon.ID)
        end
        respond_to do |format|
          format.html { redirect_back_or root_path }
          format.json { render json: {status: 'ok', data: { auth_token: user.RememberToken,is_login: false } } }
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, flash: {error: user.errors.full_messages.first} }
          format.json { render json: {status: 'error', message: user.errors.full_messages.first} }
        end
      end
    end
  end

  def send_check_code
    if (delta = session[:check_code_time].to_i - Time.now.to_i) > 0
      render json: { status: "error", message: "发送过于频繁，#{delta}秒后重试", error_code: "TOO_FREQUENT"}
    else
      session[:check_code_time] = Time.now.to_i + 60

      code = (rand(9000) + 1000).to_s
      $cache.write("#{params[:tel]}_check_code", code, :expire_in => Settings.sms.expire_in.minutes)
      if params[:isVoice] == "true"
        if Sms.send_check_code_v(params[:tel])
          render json: { status: "ok",number: Settings.sms.check_voice_number }
        else
          render json: { status: "error", message: "短信发送超过限制次数"}
        end
      else
        if Sms.send_check_code_s(params[:tel])
          render json: { status: "ok" }
        else
          render json: { status: "error", message: "短信发送超过限制次数"}
        end
      end
    end
  end

  # change by zlh
  # def send_check_voicecode
  #   if (delta = session[:check_code_time].to_i - Time.now.to_i) > 0
  #     render json: { status: "error", message: "#{delta}秒后重试"}
  #   else
  #     session[:check_code_time] = Time.now.to_i + 120
  #     if Sms.send_check_code(params[:tel])
  #       render json: { status: "ok" }
  #     else
  #       render json: { status: "error", message: "短信发送超过限制次数"}
  #     end
  #   end
  # end
  # change by lzh


  def check_mobile
    if User.find_by(Phone: params[:mobile])
      render json: { status: 'error', message: "手机号已被注册"}
    else
      render json: { status: 'ok' }
    end
  end

  private
  def user_params
    params[:user][:Phone] ||= '' # 防止网页注册时恶意删除tel参数
    params.require(:user).permit(:Phone, :check_code, :Password, :password_confirmation, :Type, :SalesmanInviteCode, :address => [:Province, :City, :County, :Detailedaddress, :ShipName, :CountyID])
  end

  private
  def set_layout
    from_mobile? ? 'mobile' : 'login_pc'
  end
end
