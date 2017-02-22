json.status 'ok'
json.data do
  json.product_brands(@product_brands) do |product_brand|
    json.id product_brand.ID
    json.product_brand product_brand.BrandName
  end
end
