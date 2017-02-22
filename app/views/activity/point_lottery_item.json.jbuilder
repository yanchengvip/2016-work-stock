json.status 'ok'
json.data do
    json.array! @point_lotteries.each do |pl|
      json.id pl.ID #奖项识别码
      json.type  pl.Type #奖品类型 0:优惠现金券,1:积分,2:商品
      json.type_name  pl.TypeName
      json.product_name pl.product.present? ? pl.product.Name : ''
      json.coupon_name pl.coupon.present? ? pl.coupon.Title : ''
      json.logo_qiniu Settings.qiniu_base_url + pl.LogoQiNiu.to_s
      json.points    pl.Points #赠送积分数
      json.level    pl.Level
    end
end