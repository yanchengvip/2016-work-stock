json.status 'ok'
json.data do
  json.point_product do
    json.id @point_order.PointProductID
    json.cover @point_order.point_product.cover_url
    json.name @point_order.point_product.Name
    json.point @point_order.point_product.Point
  end
  json.number @point_order.Number
  json.exchange_time @point_order.CreateTime.strftime("%Y-%m-%d %H:%M")
  if @point_order.Address
    json.consignee @point_order.Consignee
    json.mobile @point_order.Mobile
    json.address @point_order.Address
  end
end
