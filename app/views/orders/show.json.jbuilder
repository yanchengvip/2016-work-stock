json.status 'ok'
json.data do
  status = case @order.OrderStatus when 0 then 0 when 1,2,7 then 1 when 3 then 2 when 4,5,8 then 3 end
  json.status status
  json.ship_name @order.ShipName
  json.ship_tel @order.ShipTel
  json.address @order.Address
  json.message @order.Message
  json.code @order.OrderCode
  json.rand_num @order.RandNum
  json.products(@order.order_products) do |op|
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
  json.products_count @order.order_products.inject(0){|sum, op| sum+op.Quantity}
  json.cost_item @order.CostItem.to_f
  json.money @order.Money.to_f
  json.giveaway @order.GiveawayTotal.to_f
  json.coupon_price @order.CouponPrice.to_f
  json.submit_time (@order.SubmitDate || @order.CreateTime).try(:strftime, "%Y-%m-%d %H:%M:%S")
  json.pay_time @order.PayDatetime.try(:strftime, "%Y-%m-%d %H:%M:%S")
  json.status_show @order.status_show
  json.cancel_status @order.CanceledStatus.to_i if @order.OrderStatus.in?([1,2,7])
  json.has_score @order.order_score.present?
  json.company_name @order.company.try(:show_name)
  json.cash_volume @order.CashVolume.to_f
end
