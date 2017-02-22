# == Schema Information
#
# Table name: Cities
#
#  ID         :string(36)       default(""), not null, primary key
#  CityCode   :string(255)      not null
#  CityName   :string(255)      not null
#  ProvinceID :string(36)
#  CreateTime :datetime
#  CreateBy   :string(100)
#  UpdateTime :datetime
#  UpdateBy   :string(100)
#

class City < ActiveRecord::Base
  self.table_name = 'Cities'

  belongs_to :province, :foreign_key => "ProvinceID"
  has_many :counties, ->{order("LENGTH(CountyName), CountyCode")}, :foreign_key => "CityID"

  attr_accessor :depot_counties

  def counties_with_depot
    #@counties ||= County.select("Counties.*, dsc.DepotID").joins("left join DepotSendCounties dsc on dsc.CountyID = Counties.ID").where(CityID: self.ID)
    County.select("Counties.*, dsc.DepotID").joins("left join DepotSendCounties dsc on dsc.CountyID = Counties.ID").where(CityID: self.ID)
  end

  def append county
    @depot_counties ||= Array.new
    @depot_counties << county
  end

  def self.beijing
    #@@beijing ||= City.find_by(CityName: '北京市')
    City.find_by(CityName: '北京市')
  end

  def self.all_cities
    #@@cities ||= City.where(IsEnabled: true).order("CityCode")
    cities = City.includes(:counties).where(IsEnabled: true).order("CityCode")
    #cities_hash = Hash[cities.map{|city| [city.ID, city]}]
    #counties = County.select("Counties.*, dsc.DepotID").joins("left join DepotSendCounties dsc on dsc.CountyID = Counties.ID").where(CityID: cities.map(&:ID))
    #counties.each{|county| cities_hash[county.CityID].append county}
    return cities
  end
end
