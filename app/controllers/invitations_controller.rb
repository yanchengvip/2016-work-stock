class InvitationsController < ApplicationController
  skip_before_filter :authenticate_user!
  layout 'mobile_events'

  def index
    cookies.permanent[:share_code] = params[:share_code] if params[:share_code].present?
  end

  def accept
    if !Sms.valid?(params[:Phone], params[:check_code])
      render json: {status: 'error', message: '验证码错误!'}
    elsif Invitation.find_by(Phone: params[:Phone]) or User.find_by(Phone: params[:Phone])
      render json: {status: 'error', message: '您已领取奖励'}
    elsif cookies[:share_code].present? and (user = User.find_by(ID: Base64.decode64(cookies[:share_code])))
      user.success_invite(params[:Phone])
      render json: {status: 'ok'}
    else
      Invitation.create(Phone: params[:Phone], CouponPrice: 25, TypeID: 0, Remark: '分享成功')
      render json: {status: 'ok'}
    end
  end
end
