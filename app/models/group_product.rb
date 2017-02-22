class GroupProduct < ActiveRecord::Base
  self.table_name = 'GroupProducts'

  belongs_to :product, :class_name => "Product", :foreign_key => "ProductID"
  belongs_to :sub_product, :class_name => "Product", :foreign_key => "SubProductID"
end


