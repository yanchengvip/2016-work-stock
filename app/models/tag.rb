# == Schema Information
#
# Table name: Tags
#
#  ID         :string(36)       default(""), not null, primary key
#  Name       :string(255)
#  TagGroupID :string(36)
#  CreateTime :datetime
#  CreateBy   :string(100)
#  UpdateTime :datetime
#  UpdateBy   :string(100)
#

class Tag < ActiveRecord::Base
  self.table_name = 'Tags'
end
