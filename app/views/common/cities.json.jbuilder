json.status 'ok'
json.data(@cities) do |city|
  json.city_id city.ID
  json.city_name city.CityName
  json.company_id city.CompanyID
  json.counties(city.counties) do |county|
    json.county_id county.ID
    json.count_name county.CountyName
  end
end
