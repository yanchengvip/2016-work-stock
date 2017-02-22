# == Schema Information
#
# Table name: Streets
#
#  ID         :string(36)       default(""), not null, primary key
#  StreetName :string(255)      not null
#  StreetCode :string(255)      not null
#  CountyID   :string(36)
#  CreateTime :datetime
#  CreateBy   :string(100)
#  UpdateTime :datetime
#  UpdateBy   :string(100)
#

class Street < ActiveRecord::Base
  self.table_name = 'Streets'

  belongs_to :county, :foreign_key => "CountyID"
end
