json.status 'ok'
json.data do
  json.is_seckill @recommend.IsSeckill?
  json.title @recommend.RecommendName
  json.background_color @recommend.BackgroundColor
  json.pic_url @recommend.banners.first.try(:pic_url)
  # json.template @recommend.Template
  if !@recommend.Template.in?([1,3,9])
    json.template 0
  else
    json.template @recommend.Template
  end
  json.coupons(@coupons) do |coupon|
    json.id coupon.ID
    json.has_collect coupon.has_collect
    json.title coupon.Title
    json.price coupon.CouponPrice.to_f
    json.activity_price coupon.ActivityPrice
  end

  if @recommend.Template === 9
    @products = []
    product_ids = @activity_floors.inject([]){|a, ac| a | ac.products.map(&:ID)}
    @stocks = DepotProductStock.stocks_for(product_ids, session[:depot_ids])
    json.floors(@activity_floors) do |activity_floor|
      json.floor_url activity_floor.cover_url('v220')
      json.show_name activity_floor.ShowName
      @products = activity_floor.products.includes(:product_info, :sub_products => [:product_info])
                      .joins("left join DepotProductStocks dps on dps.ProductID = Products.ID")
                      .where("dps.State = 2 and dps.DepotID in (?) and Products.State = 2 and (ActivityBeginTime is null or (ActivityBeginTime <= ? and ActivityEndTime > ?))",session[:depot_ids], Time.now, Time.now)
      json.products(@products) do |product|
        if Company.need_stock?(product.CompanyID)
          next if !@stocks or !@stocks[product.ID] or @stocks[product.ID].State != 2
        else
          next if product.SellState != 2
        end
        json.id product.ID
        json.name product.Name
        json.cover_url product.cover_url('v220')
        json.stock @stocks[product.id].Stock if Company.need_stock?(product.CompanyID)
        json.specification product.Specification
        json.price product.ProductPrice
        json.unit product.Unit
        json.original_price product.OriginalPrice

        if product.ActivityEndTime && Time.now < product.ActivityEndTime
          json.time_left (product.ActivityEndTime - Time.now).fdiv(3600*24).ceil
        end
        json.corner_mark product.CornerMark
        json.differ_price (product.OriginalPrice - product.ProductPrice) if product.OriginalPrice && product.ProductPrice
        json.cart_num product.cart_for current_user
        json.min_buy_count product.MinBuyCount
        json.max_sale_amount_day product.MaxSaleAmountDay
      end
    end
  else
    json.products(@products) do |product|
      if Company.need_stock?(product.CompanyID)
        next if !@stocks or !@stocks[product.ID] or @stocks[product.ID].State != 2
      else
        next if product.SellState != 2
      end

      json.id product.ID
      json.name product.Name
      json.cover_url product.cover_url('v220')
      json.stock @stocks[product.id].Stock if Company.need_stock?(product.CompanyID)
      json.specification product.Specification
      json.price product.ProductPrice
      json.unit product.Unit
      json.original_price product.OriginalPrice

      if product.ActivityEndTime && Time.now < product.ActivityEndTime
        json.time_left (product.ActivityEndTime - Time.now).fdiv(3600*24).ceil
      end
      json.corner_mark product.CornerMark
      json.differ_price (product.OriginalPrice - product.ProductPrice) if product.OriginalPrice && product.ProductPrice
      json.cart_num product.cart_for current_user
      json.min_buy_count product.MinBuyCount
      json.max_sale_amount_day product.MaxSaleAmountDay
    end
  end

end
