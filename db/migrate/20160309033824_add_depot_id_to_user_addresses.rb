class AddDepotIdToUserAddresses < ActiveRecord::Migration
  def change
    add_column :UserAddresses, :DepotID, :string, length: 36

    UserAddress.find_each do |address|
      county = County.find_by(ID: address.CountyID)
      if county
        address.CompanyID = county.city.CompanyID
        depot_send_county = DepotSendCounty.find_by(CountyID: county.ID)
        address.DepotID = depot_send_county.DepotID if depot_send_county.present?
        address.save
      end
    end
  end
end
