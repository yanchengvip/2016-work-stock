if !@point_lottery.nil?
  json.status 'ok'
  json.data do
    json.id @point_lottery.ID #奖项识别码
    json.type @point_lottery.Type
    case @point_lottery.Type
      when 0
        #优惠券
        json.name @point_lottery.coupon.present? ? @point_lottery.coupon.Title : ''
      when 1
        #积分
        json.name "进货宝" + @point_lottery.Points.to_s+'积分'
      when 2
        #商品
        json.name @point_lottery.product.present? ? @point_lottery.product.Name : ''

      when 4
        json.name '再接再厉'
    end
    json.type_name @point_lottery.TypeName
    json.points @point_lottery.Points
    json.level @point_lottery.Level
  end

else
  json.status @draw_result[:status]
  json.message  @draw_result[:message]
end