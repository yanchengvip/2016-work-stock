json.status 'ok'
json.data do
  if @product_groups
    json.product_groups(@product_groups) do |group|
      json.id group.ID
      json.name group.Name
    end
  end
  if @product_brands
    json.product_brands(@product_brands) do |brand|
      json.id brand.ID
      json.name brand.BrandName
    end
  end
  json.products(@products) do |product|
    json.has_stock product.Stock == 1
    json.id product.ID
    json.name product.Name
    json.cover product.cover_url('v220')
    json.price product.ProductPrice.round(2)
    json.unit product.Unit
    json.type product.Type
    json.original_price product.OriginalPrice
    json.specification product.Specification
    json.min_buy_count product.MinBuyCount
  end
end
