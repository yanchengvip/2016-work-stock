class PasswordsController < ApplicationController
  skip_before_filter :authenticate_user!, except: [:destroy]

  # change by lzh
  skip_before_filter :set_area, only: [:new, :create,:init]
  # change by lzh

  layout :set_layout

  # change  by lzh
  before_filter :verify_redis, only: [:init]
  # change by lzh

  def new
  end

  def create
    user = User.find_by(Phone: user_params[:Phone])
    if !user
      respond_to do |format|
        format.html { redirect_to(:back, flash: {error: "用户不存在！"}) and return }
        format.json { render json: {status: 'error', message: "用户不存在！"} and return }
      end
    end
    if !Sms.valid?(user_params[:Phone], user_params[:check_code])
      respond_to do |format|
        format.html { redirect_to(:back, flash: {error: "验证码错误！"}) and return }
        format.json { render json: {status: 'error', message: "验证码错误！"} }
      end
    elsif user.update_attributes(Password: user_params[:Password], password_confirmation: user_params[:password_confirmation])
      #Sms.clear_check_code(params[:tel])
      respond_to do |format|
        format.html { redirect_to(sign_in_path, flash: {success: "修改成功！"}) and return }
        format.json { render json: {status: 'ok', return_to: sign_in_path} }
      end
    else
      respond_to do |format|
        format.html { redirect_to(:back, flash: {error: user.errors.full_messages.first}) and return }
        format.json { render json: {status: 'error', message: user.errors.full_messages.first} }
      end
    end
  end

  def init
    # if current_user.update_attributes(Password: params[:Password], password_confirmation: params[:Password])
    if current_user.update_attributes(Password: params[:Password], password_confirmation: params[:Password],IsChain: params[:IsChain],Type: 1,SalesmanInviteCode: params[:SalesmanInviteCode])
      respond_to do |format|
        format.html { redirect_to :back, flash: {success: '设置成功'}}
        # format.html { redirect_to :back, flash: {success: '设置成功'}}
        format.json { render json: {status: 'ok', return_to: session[:return_to] || '/'}}
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, flash: {error: current_user.errors.full_messages.first}}
        format.json { render json: {status: 'error', message: current_user.errors.full_messages.first} }
      end
    end
  end

  def check_mobile
    if !User.find_by(Phone: params[:mobile])
      render json: { status: 'error', message: "该手机号码未注册！"}
    else
      render json: { status: 'ok' }
    end
  end

  private
  def set_layout
    from_mobile? ? 'mobile' : 'login_pc'
  end

  def user_params
    params.require(:user).permit([:Phone, :check_code, :Password, :password_confirmation, :SalesmanInviteCode])
    # params.require(:user).permit([:Phone, :check_code, :Password, :password_confirmation])
  end
end
