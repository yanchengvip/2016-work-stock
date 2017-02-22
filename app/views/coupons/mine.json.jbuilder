json.status 'ok'
json.data do
  json.usable_coupons(@usable_coupons) do |coupon|
    json.(coupon, :ID, :Price, :CouponDiscount, :CurrentCount, :UseMoney)
    json.DiscountMoney coupon.discount_money
    json.CouponType coupon.coupon.try(:CouponType).to_i
    json.Title coupon.title
    json.SubTitle coupon.sub_title
    json.TypeName coupon.type_name
    json.StartDate (coupon.StartDate || Date.today).strftime("%Y.%m.%d")
    json.EndDate coupon.EndDate.strftime("%Y.%m.%d")
  end
  json.unusable_coupons(@unusable_coupons) do |coupon|
    json.(coupon, :ID, :Price, :CouponDiscount, :CurrentCount, :UseMoney)
    json.DiscountMoney coupon.discount_money
    json.CouponType coupon.coupon.try(:CouponType).to_i
    json.Title coupon.title
    json.SubTitle coupon.sub_title
    json.TypeName coupon.type_name
    json.StartDate (coupon.StartDate || Date.today).strftime("%Y.%m.%d")
    json.EndDate coupon.EndDate.strftime("%Y.%m.%d")
  end
end
