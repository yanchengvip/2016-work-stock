class OrderGroup < ActiveRecord::Base
  self.table_name = 'OrderGroups'
  include UUIDHelper

  has_many :orders, ->{order("ThirdType")}, :foreign_key => "OrderGroupID"
end
