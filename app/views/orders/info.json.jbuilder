json.status 'ok'
json.data do
  json.cash_voulme current_user.CashVolume.to_f
  if current_user.default_address
    address = current_user.default_address
    city = City.joins("left join Provinces p on p.ID = Cities.ProvinceID").where("Cities.CityName = ? and p.ProvinceName = ?", address.City, address.Province ).first
    json.invitation_need (city.ID).in?(["7f88c460-7fe7-4137-a49e-91424060eae6","2e9c1094-bd40-41d9-9e59-3b51064b6c94", "1eb3007e-da4f-40f3-b3e3-8874f43d8514"]) ? true : false
    store_info = address.store_information
    json.address do
      json.id address.ID
      json.county_id address.CountyID
      json.mobile address.Mobile
      json.ship_name address.ShipName
      json.province address.Province
      json.city address.City
      json.county address.County
      json.detail address.Detailedaddress
      json.status store_info.blank? ? "no" : (case store_info.Status when 0 then 'faild' when 1 then 'ing' when 2 then 'success' end)
    end
  end
  json.orders(@order_group.orders) do |order|
    json.company third_name(order.company)
    json.third_type order.company.ThirdType
    json.id order.ID
    order_products = order.order_products.includes(:product => [:product_info])
    json.products(order_products) do |op|
      json.name op.product.Name
      json.cover op.product.cover_url('v100')
      json.unit op.product.Unit
      json.product_type op.product.Type
      json.quantity op.Quantity
      json.price op.Price
      if op.product.is_group_product?
        json.sub_products(op.product.group_products.includes(:sub_product => [:product_info])) do |gp|
          json.name gp.sub_product.Name
          json.number gp.Number
        end
      end
    end
    need_max = order.Money.round(2) * 200
    need_max = 100 * 200 if need_max > 100 * 200
    integral = current_user.Integral.to_i > need_max ? need_max : current_user.Integral.to_i
    json.integral integral
    json.costitem order.CostItem
    json.giveaway order.GiveawayTotal
    json.money order.Money
  end
end
