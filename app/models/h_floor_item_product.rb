class HFloorItemProduct < ActiveRecord::Base
  self.table_name = 'hflooritemproducts'

  belongs_to :product, foreign_key: "ProductID"
end
