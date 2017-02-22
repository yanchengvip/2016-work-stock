# Type:
# 1: 满送优惠券  2: 满减  3: 满折  4: 满赠
if !@activities.nil?
json.status 'ok'
discount = ''
gift_coupon_price = ''
json.data do

  json.array! @activities  do |ac|
     json.id ac.ID
     json.title ac.Title
     json.type ac.Type
     if ac.Type == 2
       gift_coupon_price = ac.GiftCouponPrice
     end
     if ac.Type == 3
       discount = ac.Discount
     end
     json.gift_coupon_price ac.GiftCouponPrice
     json.discount ac.Discount
     json.begin_date ac.BeginDate.strftime ('%Y-%m-%d %H:%M')
     json.end_date ac.EndDate.strftime ('%Y-%m-%d %H:%M')
     if ac.Type == 4 && !ac.activity_products.nil?
        json.products do
           json.array! ac.activity_products do |ap|
               json.id ap.ID
               json.activity_id ap.ActivityID
               json.product_id ap.ProductID
               json.product_code ap.ProductCode
               json.product_name ap.ProductName
               json.gift_number ap.GiftNumber
           end
        end
     end
  end


end
json.discount discount
json.gift_coupon_price gift_coupon_price
else
json.status 'ok'
json.data []
end