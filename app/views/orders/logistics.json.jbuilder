json.status 'ok'
json.data do
  json.cover @order.order_products.first.product.cover_url('v100')
  json.status @order.status_str
  json.code @order.OrderCode
  json.mobile @order.DriverMobile
  json.logistics(@order.logistics_logs) do |log|
    json.content log.logistics_status
    json.time log.OperationDate.strftime("%Y-%m-%d %H:%M:%S")
  end
end
