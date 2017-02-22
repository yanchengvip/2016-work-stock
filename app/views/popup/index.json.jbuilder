json.status 'ok'
json.data(@popup_configs) do |popup|
  json.type popup.Condition
  json.picture_url popup.picture_url.to_s
  json.link popup.SkipLink
  if popup.Condition == 2
    city = popup.city
    gift_bag = GiftBag.find_by(CompanyID: city.CompanyID, State: 1, Status: 2,Type: 0)
    json.coupon_price gift_bag.Money.to_i
  elsif current_user and popup.Condition == 3
    json.coupons(current_user.unread_coupons(popup.CityID)) do |coupon|
      json.(coupon, :ID, :Price, :CouponDiscount, :UseMoney)
      json.CouponType coupon.coupon.try(:CouponType)
      json.LogoUrl coupon.coupon.try(:LogoUrl).to_s
      json.Title coupon.title
      json.SubTitle coupon.sub_title
      json.TypeName coupon.type_name
      json.StartDate (coupon.StartDate || Date.today).strftime("%Y.%m.%d")
      json.EndDate coupon.EndDate.strftime("%Y.%m.%d")
    end
    current_user.unread_coupons(popup.CityID).update_all(IsRead: true)
  end
end


