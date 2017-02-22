json.status 'ok'
json.data do
  county = County.find_by(ID: @address.CountyID)
  if county
    json.county county.CountyName
    json.city county.city.try(:CityName)
    json.company_id county.city.try(:CompanyID)
    json.county_id @address.CountyID
    json.city_id county.CityID
  end
end
