json.status 'ok'
json.data do
  json.stocks(@order_products) do |op|
    json.product_id op.ProductID
    if (stock = @stocks[op.ProductID].present? ? @stocks[op.ProductID].Stock : 0) >= 60
      json.is_enough true
    else
      json.is_enough false
      json.stock stock
    end
  end
end
