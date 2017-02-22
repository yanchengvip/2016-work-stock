class EnterProduct < ActiveRecord::Base
  self.table_name = 'EnterProducts'

  belongs_to :product, :foreign_key => "ProductID"
end
