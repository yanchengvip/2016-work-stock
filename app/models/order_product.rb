# == Schema Information
#
# Table name: OrderProducts
#
#  ID            :string(36)       default(""), not null, primary key
#  OrderID       :string(36)
#  Quantity      :integer          not null
#  ProductName   :string(255)
#  ProductCode   :string(255)
#  Specification :string(255)
#  WarehouseID   :integer
#  Price         :decimal(18, 2)
#  ProductID     :string(36)
#  CreateTime    :datetime
#  CreateBy      :string(100)
#  UpdateTime    :datetime
#  UpdateBy      :string(100)
#  RetrunNumber  :integer
#  BadNumber     :integer
#  DiscountPrice :decimal(18, 2)
#

class OrderProduct < ActiveRecord::Base
  self.table_name = 'OrderProducts'
  include UUIDHelper

  belongs_to :product, :foreign_key => "ProductID"
  has_many   :order_group_products, :foreign_key => "OrderProductID"

  def is_enough?
  	true
  end

end
