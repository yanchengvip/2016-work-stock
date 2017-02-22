# == Schema Information
#
# Table name: DepotSendCounties
#
#  ID         :string(36)       default(""), not null, primary key
#  DepotID    :string(36)       default(""), not null
#  CountyID   :string(36)       default(""), not null
#  CreateTime :datetime
#  CreateBy   :string(100)
#  UpdateTime :datetime
#  UpdateBy   :string(100)
#

class DepotSendCounty < ActiveRecord::Base
  self.table_name = 'DepotSendCounties'

  def self.get_depots_by county_id
    DepotSendCounty.where(CountyID: county_id).map(&:DepotID)
  end

  # 获取自营公司和仓库的ID,一个区域只存在一个自营仓库
  def self.get_company_depot_by county_id
    depot_ids = DepotSendCounty.where(CountyID: county_id).pluck(:DepotID)
    @depot = Depot.includes(:company).where(ID: depot_ids,'frameworkcompanies.ThirdType': 0).first
    return {company_id: @depot.company.ID,depot_id: @depot.ID} if @depot
  end
end
