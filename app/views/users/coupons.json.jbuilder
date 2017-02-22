json.status 'ok'
json.data do
  json.picture do
    json.url image_url("mobile/coupon/buyCoupons-link.jpg")
    json.link "/coupon/sales"
  end
  json.coupons(@coupons) do |coupon|
    json.id coupon.ID
    json.type coupon.coupon.try(:CouponType).to_i
    json.type_name coupon.type_name
    json.title coupon.title
    json.sub_title coupon.sub_title
    json.price coupon.Price
    json.discount (coupon.CouponDiscount * 10).round(1).to_f if coupon.coupon and coupon.coupon.CouponType == 5
    json.use_money coupon.UseMoney
    json.count coupon.CurrentCount
    json.status coupon.coupon.try(:CouponStatus).to_i
    json.start_date (coupon.StartDate || Date.today).strftime("%Y.%m.%d")
    json.end_date coupon.EndDate.strftime("%Y.%m.%d")
    json.use_url coupon.use_url
    json.use_money coupon.UseMoney
    company = coupon.coupon.try(:company)
    json.cities company.company_cities.map(&:CityID) if company
    json.create_time coupon.CreateTime.strftime('%Y/%m/%d %H:%M:%S')
  end
end
