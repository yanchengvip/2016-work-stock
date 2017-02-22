if @products.length != 0
  json.status 'ok'
  json.data do
    json.products(@products) do |product|
      json.third_type product.ThirdType
      json.name product.Name
      json.product_price product.ProductPrice
      json.original_price product.OriginalPrice
      json.max_sale_amount_day product.MaxSaleAmountDay
      json.product_brand_name product.ProductBrandName
      json.specification product.Specification
      json.shelflife product.product_info.Shelflife
      json.cover_qiniu product.cover_url
    end
  end
else
  json.status 'no'
  json.message '抱歉,没有找到该商品'
end


















