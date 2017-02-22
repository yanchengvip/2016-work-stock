class Notification < ActiveRecord::Base
  include UUIDHelper

  def type_str
    case self.Type
    when 0
      "积分到账"
    when 1
      "优惠券到账"
    when 2
      "优惠券过期提醒"
    when 3
      "取消订单成功"
    when 4
      "取消订单失败"
    end
  end

  def link
    case self.Type
    when 0
      "/mall"
    when 1,2
      "/my/coupons"
    when 3,4
      order_code = self.Content.match(/(F\d+)/) && $1
      "/orders/#{order_code}"
    end
  end
end
