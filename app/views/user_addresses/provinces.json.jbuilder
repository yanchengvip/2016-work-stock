json.status 'ok'
json.data(@provinces) do |province|
  json.id province.ID
  json.name province.ProvinceName
end
