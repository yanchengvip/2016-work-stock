class GiftBagCoupon < ActiveRecord::Base
  belongs_to :coupon, foreign_key: "CouponID"
end
