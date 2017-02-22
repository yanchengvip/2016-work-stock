json.status 'ok'
json.data do
  1.upto(4) do |type|
    json.set! type do
      json.(@coupons[type].to_a) do |coupon|
        json.id coupon.ID
        json.has_collect coupon.has_collect
        json.logo_url coupon.LogoUrl
        json.title coupon.Title
        json.sub_title coupon.SubTitle
        json.price coupon.CouponPrice.to_f
      end
    end
  end
end
