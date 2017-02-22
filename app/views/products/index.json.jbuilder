json.status 'ok'
json.data do
  products = @recommend_products.to_a | @products.to_a
  json.products(products) do |product|
    if Company.need_stock?(product.CompanyID)
      next if !@stocks or !@stocks[product.ID] or @stocks[product.ID].State != 2
    else
      next if product.SellState != 2
    end
    json.id product.ID
    json.cover product.cover_url('v220')
    json.name product.Name
    json.price product.ProductPrice.round(2)
    json.unit product.Unit
    json.type product.Type
    json.specification product.Specification
    json.max_sale_amount product.MaxSaleAmount
    json.max_sale_amount_day product.MaxSaleAmountDay
    json.original_price product.OriginalPrice
    json.slogan product.Slogan if product.Slogan.present?
    json.corner_mark product.CornerMark
    json.activity_end_time product.ActivityEndTime && product.ActivityEndTime.strftime('%Y-%m-%d %H:%M:%S')
    json.third_type product.company.ThirdType.to_i
    if Company.need_stock?(product.CompanyID)
      if !@stocks or !@stocks[product.ID] or @stocks[product.ID].Stock + @stocks[product.ID].PreSaleQuantity <= 0
        json.stock 0
      elsif @stocks[product.ID].Stock + @stocks[product.ID].PreSaleQuantity < 60
        json.stock @stocks[product.ID].Stock + @stocks[product.ID].PreSaleQuantity
      end
    end
    json.min_buy_count product.MinBuyCount || 1
    json.sub_products(product.group_products) do |group_product|
      json.number group_product.Number
      json.name group_product.SubProductName
      json.unit group_product.sub_product.Unit
    end
    json.cart_num product.cart_for current_user
  end
  json.total_pages @products.total_pages
  json.current_page @products.current_page
end
