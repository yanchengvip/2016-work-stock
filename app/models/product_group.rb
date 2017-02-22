# == Schema Information
#
# Table name: ProductGroups
#
#  ID         :string(36)       default(""), not null, primary key
#  Name       :string(255)
#  Pic        :integer
#  Describe   :text(4294967295)
#  State      :integer          not null
#  OrderBy    :integer          not null
#  Level      :integer
#  TagG       :integer
#  ParentID   :string(36)
#  CreateTime :datetime
#  CreateBy   :string(100)
#  UpdateTime :datetime
#  UpdateBy   :string(100)
#

class ProductGroup < ActiveRecord::Base
  self.table_name = 'ProductGroups'

  has_many :second_groups, -> {where(State: 1)}, :class_name => "ProductGroup", :foreign_key => "ParentID"
  has_many :tag_groups, :foreign_key => "ProductGroupID"

  def self.drink
    @drink_group ||= ProductGroup.find_by(Name: '饮料')
  end

  def self.food
    @food_group ||= ProductGroup.find_by(Name: '食品')
  end

  def self.wine
    @wine_group ||= ProductGroup.find_by(Name: '酒水')
  end

  def self.group
    @wine_group ||= ProductGroup.find_by(Name: '优惠套餐')
  end

  def self.first_groups(city_id)
    ProductGroup.joins("left join CompanyProductGroups cpg on cpg.ProductGroupID = ProductGroups.ID").where("Level = 1 and State = 1 and CityID = ? and IsEnable = 1", city_id).order("OrderBy")
  end

  def self.second_groups
    ProductGroup.where(Level: 2, State: 1).order("OrderBy")
  end

  def second_groups_by(city_id)
    ProductGroup.joins("left join CompanyProductGroups cpg on cpg.ProductGroupID = ProductGroups.ID").where("ParentID = ? and State = 1 and CityID = ? and IsEnable = 1", self.ID, city_id).order("OrderBy")
  end
end
