json.status 'ok'
json.cart_for_nav current_user.cart_for_nav(session[:depot_ids],session[:company_id]).first
json.data(@order_group.orders) do |order|
  json.company order.company.show_name
  json.code order.OrderCode
  json.money order.Money
end
