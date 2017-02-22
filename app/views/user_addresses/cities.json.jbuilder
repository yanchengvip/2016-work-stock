json.status 'ok'
json.data(@cities) do |city|
  json.id city.ID
  json.name city.CityName
end
