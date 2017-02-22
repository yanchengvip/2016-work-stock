class ProductActivityUser < ActiveRecord::Base
  self.table_name = 'ProductActivityUsers'
  include UUIDHelper
end
