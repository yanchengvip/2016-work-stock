products = []
@product.present? ? (products << @product) : products = @products.to_a
json.status 'ok'
if products.length != 0
  product_ids = products.map(&:ID)
  stocks = DepotProductStock.stocks_for(product_ids, session[:depot_ids])
  json.data(products) do |product|
    json.id product.ID
    json.third_type product.company.ThirdType
    # json.state product.State
    json.image_url product.cover_url
    if product.State !=2 or !stocks or !stocks[product.ID] or stocks[product.ID].State != 2
      json.off_the_shelf  true
    elsif Company.need_stock?(session[:company_id])
      if !stocks or !stocks[product.ID] or (stocks[product.ID].Stock + stocks[product.ID].PreSaleQuantity) <= 0
        json.replenishment true
      else
        json.stock stocks[product.ID].Stock + stocks[product.ID].PreSaleQuantity
      end
    end
    json.name product.Name
    json.product_price product.ProductPrice
    json.original_price product.OriginalPrice
    json.max_sale_amount_day product.MaxSaleAmountDay.to_i
    json.product_brand_name product.product_brandname
    json.sepcification product.Specification
    json.min_buy_count product.MinBuyCount.to_i
    json.unit product.Unit
    json.shelflife product.product_info.Shelflife
    json.cart_num product.cart_for(current_user)
  end
else
  company_id = session[:company_id] || City.beijing.CompanyID
  @floors = HFloor.includes(:floor_items).joins("left join HPageConfigs hpc on hpc.ID = HFloors.HPageConfigID").where("hpc.IsEnabled = true and hpc.CompanyID = ? and hpc.TerminalType = 1 and hfloors.IsEnabled = true and hfloors.LayoutType = 2", company_id).order("Sort")
  items = @floors.first.floor_items

  if items.present?
    item = items.first
    product = item.rush_products(session[:depot_ids]).where("ActivityBeginTime > ?", Time.now).order("ActivityBeginTime").first
    product_current = item.rush_products(session[:depot_ids]).where("ActivityBeginTime < ? and ActivityBeginTime > ?", Time.now, Date.today).order("ActivityBeginTime").last
    product_current ||= product
    if product_current
      json.link item.recommend_link || item.LinkUrl
      json.begin_time product.ActivityBeginTime.strftime("%Y-%m-%d %H:%M:%S") if product
    end
  end
end