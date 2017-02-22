json.status 'ok'
json.data do
  json.is_seckill @recommend.IsSeckill?
  json.cart_for_nav current_user.cart_for_nav(session[:depot_ids],session[:company_id]).first
  json.background_color @recommend.BackgroundColor
  json.pic_url @recommend.banners.first.try(:pic_url)
  json.today_products(@today_products) do |product|
    json.status product.ActivityBeginTime > Time.now ? "end_buy" : (product.CurrentActivityAmount.to_i < product.MaxActivityAmount.to_i && product.ActivityEndTime > Time.now ? "now_buy" : "end_buy")
    json.begin_time product.ActivityBeginTime.strftime("%Y-%m-%d %H:%M:%S")
    json.percent ((product.MaxActivityAmount.to_i - product.CurrentActivityAmount.to_i).fdiv(product.MaxActivityAmount.to_i)*100).round(0)
    json.id product.ID
    json.name product.Name
    json.cover_url product.cover_url('v100')
    json.price product.ProductPrice
    json.unit product.Unit
    json.original_price product.OriginalPrice
    json.specification product.Specification
    json.cart_num product.cart_for current_user
  end
  json.tomorrow_products(@tomorrow_products) do |product|
    json.begin_time product.ActivityBeginTime.strftime("%Y-%m-%d %H:%M:%S")
    json.id product.ID
    json.name product.Name
    json.cover_url product.cover_url('v100')
    json.price product.ProductPrice
    json.unit product.Unit
    json.original_price product.OriginalPrice
    json.specification product.Specification
    json.cart_num product.cart_for current_user
  end
end
