json.status 'ok'
json.data(@point_orders) do |point_order|
  json.point_product do
    json.id point_order.PointProductID
    json.cover point_order.point_product.cover_url
    json.name point_order.point_product.Name
    json.point point_order.point_product.Point
  end
  json.number point_order.Number
  json.exchange_time point_order.CreateTime.strftime("%Y-%m-%d %H:%M")
end
