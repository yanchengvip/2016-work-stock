class CheckIn < ActiveRecord::Base
  self.table_name = 'CheckIns'
  include UUIDHelper
end
