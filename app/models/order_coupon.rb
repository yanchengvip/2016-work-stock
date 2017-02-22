class OrderCoupon < ActiveRecord::Base
  include UUIDHelper
  belongs_to :user_coupon, :foreign_key => "UserCouponID"
end
