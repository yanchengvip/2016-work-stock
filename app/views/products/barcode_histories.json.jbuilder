json.status 'ok'
if !@barcode_histories.nil? && @products != nil
  json.data(@products) do |product|
    json.id product.ID
    # json.link "/products/barcode_scanner?ID=#{product.ID}&MoreThanOne=true&FromHistories=true"
    json.name truncate(product.Name,length: 38)
    json.image product.cover_url
    json.third_type product.ThirdType
    json.product_price product.ProductPrice
    json.unit product.Unit
    json.create_time time_ago_in_words(product.CreateTime)
  end
end