# == Schema Information
#
# Table name: ProductStockLogs
#
#  ID           :string(36)       default(""), not null, primary key
#  DataID       :string(36)
#  ProductCode  :string(255)
#  ProductName  :string(255)
#  ChangeNumber :integer
#  Unit         :string(255)
#  ChangeType   :integer          not null
#  IP           :string(255)
#  Agent        :string(255)
#  CreateTime   :datetime
#  CreateBy     :string(100)
#  UpdateTime   :datetime
#  UpdateBy     :string(100)
#  DataDetailID :string(36)
#  ProductID    :string(36)
#  BeforeNumber :integer
#  DepotID      :string(36)
#

class ProductStockLog < ActiveRecord::Base
  self.table_name = 'ProductStockLogs'

  include UUIDHelper
end
