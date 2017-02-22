# == Schema Information
#
# Table name: Counties
#
#  ID         :string(36)       default(""), not null, primary key
#  CountyName :string(255)      not null
#  CountyCode :string(255)      not null
#  CityID     :string(36)
#  CreateTime :datetime
#  CreateBy   :string(100)
#  UpdateTime :datetime
#  UpdateBy   :string(100)
#

class County < ActiveRecord::Base
  self.table_name = 'Counties'

  belongs_to :city, :foreign_key => "CityID"
end
