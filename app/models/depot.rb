class Depot < ActiveRecord::Base
  self.table_name = 'Depots'
  belongs_to :company,foreign_key: 'CompanyID'
  def self.daxing
    @@daxing ||= Depot.find_by(ID: 'f6d48bbd-ef85-4d70-a810-eaf327682c1b')
  end

  def self.find_by_address address
    return Depot.joins("left join DepotSendCounties dsc on dsc.DepotID = Depots.ID").where("dsc.CountyID = ?", address.CountyID).first if address
  end
end


# pry(main)> Depot.joins(:company).where(ID:  ["d2cf9c06-4cee-4ff8-9716-c4800746172a", "2fb4dc57-c3cc-4c27-ab55-f217a1aba9d0"],'frameworkcompanies.ThirdType': 0).map(&:ID)
# Depot Load (5.2ms)  SELECT `Depots`.* FROM `Depots` INNER JOIN `frameworkcompanies` ON `frameworkcompanies`.`ID` = `Depots`.`CompanyID` WHERE `Depots`.`ID` IN ('d2cf9c06-4cee-4ff8-9716-c4800746172a', '2fb4dc57-c3cc-4c27-ab55-f217a1aba9d0') AND `frameworkcompanies`.`ThirdType` = 0
# => ["d2cf9c06-4cee-4ff8-9716-c4800746172a"]
