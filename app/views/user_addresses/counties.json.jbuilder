json.status 'ok'
json.data(@counties) do |county|
  json.id county.ID
  json.name county.CountyName
end
