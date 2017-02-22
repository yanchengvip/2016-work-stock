# == Schema Information
#
# Table name: TagGroups
#
#  ID             :string(36)       default(""), not null, primary key
#  Name           :string(255)
#  ProductGroupID :string(36)
#  CreateTime     :datetime
#  CreateBy       :string(100)
#  UpdateTime     :datetime
#  UpdateBy       :string(100)
#

class TagGroup < ActiveRecord::Base
  self.table_name = 'TagGroups'

  has_many :tags, :foreign_key => "TagGroupID"
end
