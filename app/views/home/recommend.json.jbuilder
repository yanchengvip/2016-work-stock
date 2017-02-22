json.status 'ok'
json.data(@item_products) do |product|
  json.id product.ID
  json.name product.Name
  json.cover product.cover_url('v400')
  json.corner_mark product.CornerMark
  json.price product.ProductPrice.round(2)
  json.unit product.Unit
  json.min_buy_count product.MinBuyCount || 1
  json.cart_num product.cart_for current_user
  json.list_attrs_json product.list_attrs_json
end
