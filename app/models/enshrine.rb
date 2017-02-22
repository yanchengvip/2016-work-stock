# == Schema Information
#
# Table name: Enshrines
#
#  ID         :string(36)       default(""), not null, primary key
#  CreateTime :datetime
#  CreateBy   :string(100)
#  UpdateTime :datetime
#  UpdateBy   :string(100)
#  ProductID  :string(36)
#  UserID     :string(36)
#

class Enshrine < ActiveRecord::Base
  self.table_name = "Enshrines"
  include UUIDHelper

  belongs_to  :user, :foreign_key => "UserID"
  belongs_to  :product, :foreign_key => "ProductID"

end
