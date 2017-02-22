json.status 'ok'
json.data(@addresses) do |address|
  city = City.joins("left join Provinces p on p.ID = Cities.ProvinceID").where("Cities.CityName = ? and p.ProvinceName = ?", address.City, address.Province ).first
  json.invitation_need (city.ID).in?(["7f88c460-7fe7-4137-a49e-91424060eae6","2e9c1094-bd40-41d9-9e59-3b51064b6c94", "1eb3007e-da4f-40f3-b3e3-8874f43d8514"]) ? true : false
  store_info = address.store_information
  json.status store_info.blank? ? "no" : (case store_info.Status when 0 then 'faild' when 1 then 'ing' when 2 then 'success' end)
  json.id address.ID
  json.ship_name address.ShipName
  json.mobile address.Mobile
  json.province address.Province
  json.city address.City
  json.county address.County
  json.detail_address address.Detailedaddress
  json.face_name address.FaceName
  json.store_type store_info.try(:StoreType)
  json.near_by store_info.try(:Nearby)
  json.store_area store_info.try(:StoreArea)
  json.reject_reason store_info.try(:RejectReason)
end
