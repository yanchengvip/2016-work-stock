# == Schema Information
#
# Table name: Provinces
#
#  ID           :string(36)       default(""), not null, primary key
#  ProvinceName :string(255)      not null
#  ProvinceNo   :string(255)      not null
#  CreateTime   :datetime
#  CreateBy     :string(100)
#  UpdateTime   :datetime
#  UpdateBy     :string(100)
#

class Province < ActiveRecord::Base
  self.table_name = 'Provinces'

  has_many :cities, ->{order("CityCode")}, :foreign_key => "ProvinceID"

end
