class GiftBag < ActiveRecord::Base
  has_many :gift_bag_coupons, foreign_key: "GiftBagID"
  has_many :coupons, through: :gift_bag_coupons
end
