json.status 'ok'
json.data(@coupons) do |coupon|
  json.(coupon, :ID, :Title, :SubTitle, :CouponType, :ActivityPrice, :LogoUrl, :CouponPrice)
  json.BeginTime coupon.BeginTime.strftime("%Y.%m.%d")
  json.EndTime coupon.EndTime.strftime("%Y.%m.%d")
  json.HasCollect coupon.has_collect
end
