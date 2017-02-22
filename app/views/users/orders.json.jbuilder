json.status 'ok'
json.data(@orders) do |order|
  json.company_name order.company.try(:show_name)
  json.code order.OrderCode
  json.rand_num order.RandNum
  json.products(order.order_products) do |op|
    json.name op.product.Name
    json.cover op.product.cover_url('v100')
    json.unit op.product.Unit
    json.quantity op.Quantity
    json.price op.Price
    if op.product.is_group_product?
      json.sub_products(op.product.group_products.includes(:sub_product => [:product_info])) do |gp|
        json.name gp.sub_product.Name
        json.number gp.Number
      end
    end
  end
  json.products_count order.order_products.inject(0){|sum, op| sum+op.Quantity}
  json.money order.Money.to_f
  json.giveaway order.giveaway_total.round(2)
  json.status_show order.status_show
  json.cancel_status order.CanceledStatus.to_i if order.OrderStatus.in?([1,2,7])
  json.has_score order.order_score.present?
end
