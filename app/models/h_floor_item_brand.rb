class HFloorItemBrand < ActiveRecord::Base
  self.table_name = "hflooritembrands"

  belongs_to :product_brand, foreign_key: "ProductBrandID"
end
