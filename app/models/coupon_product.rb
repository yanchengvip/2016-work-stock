class CouponProduct < ActiveRecord::Base
  belongs_to :product, :foreign_key => "ProductID"
end
