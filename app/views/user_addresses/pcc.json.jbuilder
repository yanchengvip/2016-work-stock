json.status 'ok'
json.data do
  json.provinces(@provinces) do |province|
    json.name province.ProvinceName
    json.cities(province.cities) do |city|
      json.name city.CityName
      json.counties(city.counties) do |county|
        json.name county.CountyName
      end
    end
  end
end
