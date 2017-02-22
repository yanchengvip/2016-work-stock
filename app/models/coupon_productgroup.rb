class CouponProductgroup < ActiveRecord::Base
  belongs_to :product_group, foreign_key: "ProductGroupID"
end
