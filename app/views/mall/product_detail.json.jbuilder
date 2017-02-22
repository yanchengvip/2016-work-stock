json.status 'ok'
json.data do
  json.name @point_product.Name
  json.cover @point_product.cover_url
  json.point @point_product.Point
  json.regulation @point_product.Regulation
  json.summary @point_product.Summary
  json.max_number @point_product.MaxExchangeNumber
  json.type @point_product.Type
end
