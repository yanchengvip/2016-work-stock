class NoticeController < ApplicationController
  def index
    @notification = current_user.notifications.first
  end

  def mine
    @notifications = current_user.notifications
    current_user.notifications.update_all(IsRead: true)
  end

  def will_dated_coupons
    notification = current_user.notifications.where(Type: 2, IsRead: 0).first
    render json: {status: 'ok', data: {content: notification.try(:Content)}}
  end
end
