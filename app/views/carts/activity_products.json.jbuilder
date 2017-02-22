json.status 'ok'
json.data do
  @carts_group = sign_in? ? current_user.carts_group(session[:depot_ids]) : {}
  @activities = Activity.city_activities(@carts_group.keys, session[:city_id])
  # 添加购物车页面上面满减和满赠两种活动的接口数据
  json.carts_group(@carts_group) do |key, carts|

    company = carts.first.company
    json.company_id company.id
    if @activities[key]
      json.activities_top(@activities[key]) do |activity|
        if activity.Type == 4
          json.type activity.Type
          json.activity_price activity.ActivityPrice
          json.activity_product activity.activity_products.first.ProductName
        elsif activity.Type == 2
          json.type activity.Type
          json.activity_price activity.ActivityPrice
          json.activity_product activity.SubPrice
        end
      end
    end
  end

end



