class CouponProductbrand < ActiveRecord::Base
  belongs_to :product_brand, foreign_key: "ProductBrandID"
end
