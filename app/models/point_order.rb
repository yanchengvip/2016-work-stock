class PointOrder < ActiveRecord::Base
  self.table_name = 'PointOrders'
  include UUIDHelper

  belongs_to :point_product, :foreign_key => "PointProductID"
end
