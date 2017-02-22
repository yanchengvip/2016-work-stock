json.status 'ok'
json.data do
  @cart_price = 0
	json.carts_group(@carts_group) do |key, carts|
    company = Company.find_by(ID: key)
    # company_city = CompanyCity.find_by(CompanyID: key, CityID: cookies[:city_id])
    company_city = CompanyCity.find_by(CompanyID: key, CityID: session[:city_id])
    json.group_title company.show_name
    json.company_id company.ID
    json.third_type company.ThirdType
    json.deliver_money company_city.try(:SendPrice).to_i
    json.deliver_sku company_city.try(:SkuCount).to_i
    json.activities @activities[key].present? ? @activities[key].map(&:Title) : []

    need_stock = Company.need_stock?(company.ID)
    json.carts(carts) do |cart|
      json.id cart.ID
      json.is_checked cart.is_checked?
      json.number cart.Number
      json.product_id cart.ProductID
      json.product_type cart.product.Type
      json.product_img cart.product.cover_url('v100')
      json.product_name cart.product.Name
      json.product_unit cart.product.Unit
      json.product_price cart.product.ProductPrice
      json.product_specification cart.product.Specification
      if need_stock
        if ( @stocks[cart.ProductID] && @stocks[cart.ProductID].State != 2 ) or cart.product.State != 2
          json.product_stock 0
        elsif @stocks[cart.ProductID] and @stocks[cart.ProductID].Stock.to_i < 60
          json.product_stock @stocks[cart.ProductID].Stock.to_i
        end
      else
        json.product_stock 0 if (cart.product.State != 2 or cart.product.SellState != 2)
      end

      json.max_sale_amount cart.product.MaxSaleAmountDay
      json.min_buy_count cart.product.MinBuyCount
      json.corner_mark cart.product.CornerMark
      json.activity_end_time cart.product.ActivityEndTime && cart.product.ActivityEndTime.strftime('%Y-%m-%d %H:%M:%S')
      if cart.product.is_group_product?
        g_products = cart.product.group_products.includes(:sub_product => [:product_info])
        json.sub_products(g_products) do |g_product|
          json.number g_product.Number
          json.price g_product.SubProductPrice
          json.name g_product.SubProductName
          json.unit g_product.sub_product.Unit
          json.cover g_product.sub_product.cover_url('v100')
        end
      end

      # @cart_price = @cart_price + cart.product.ProductPrice * cart.Number
    end

  end
  # json.cart_price @cart_price
end



