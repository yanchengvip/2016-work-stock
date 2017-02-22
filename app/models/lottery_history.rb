class LotteryHistory < ActiveRecord::Base
  self.table_name = 'LotteryHistories'
  belongs_to :user, :foreign_key => "UserID"
  include UUIDHelper


  # 记录商品被使用的订单ID
  def self.product_set_order_id current_user,order
    order.products.where(Type: 4).each do |product|
      lhs = LotteryHistory.where('UserID = ? and Type = ? and ObjectID = ? and CreateTime > ?  and OrderID is null',
                                 current_user.ID, 2, product.ID, Time.now - 7.days)
      lhs.each do |lh|
        lh.update_attributes(OrderID: order.ID)
      end
    end
  end

  # 记录优惠券被使用的订单ID
  def self.coupon_set_order_id user_coupon,order
    lh = LotteryHistory.where(UserCouponID: user_coupon.ID).first
    lh.update_attributes(OrderID: order.ID) if lh.present?
  end
end
