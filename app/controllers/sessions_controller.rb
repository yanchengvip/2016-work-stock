class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_filter :authenticate_user!, except: [:destroy]
  skip_before_filter :set_area
  layout :set_layout

  def new

    sign_out if sign_in?

    @advertise_pics = AdvertisePic.where("AdvertisePicGroupID = 'f7272e8b-02b1-4b38-9ab3-2e4301800f47'").order("OrderBy")
  end

  def create
    user = User.find_by(Phone: params[:session][:tel].downcase)

    if user && user.authenticate(params[:session][:password])
      sign_in user
      respond_to do |format|
        format.html { redirect_back_or root_path }
        format.json { render json: {status: 'ok', data: { auth_token: user.RememberToken} , return_to: session[:return_to] || '/' } }
      end
    else
      flash["tel"] = params[:session][:tel].downcase
      respond_to do |format|
        format.html { redirect_to sign_in_path, flash: {error: '手机号或密码不正确!'} }
        format.json { render json: {status: 'error', message: '手机号或密码不正确!'} }
      end
    end

  end

  def secret_login
    user = User.find_by(Phone: params[:tel])
    if params[:key] == Digest::MD5.hexdigest([params[:tel], user.RememberToken, '?jhb?'].join(''))
      sign_in user
    end
    redirect_to root_path
  end

  def destroy
    sign_out
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.json { render json: {status: 'ok'} }
    end
  end

  private
  def set_layout
    from_mobile? ? 'mobile' : 'login_pc'
  end

end
