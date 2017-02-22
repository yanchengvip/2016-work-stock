class HFloorItemGroup < ActiveRecord::Base
  self.table_name = "hflooritemGroups"

  belongs_to :product_group, foreign_key: "ProductGroupID"
end
