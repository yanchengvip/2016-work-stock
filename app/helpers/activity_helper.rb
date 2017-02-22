module ActivityHelper

  #判断是否显示剩余时间
  def is_show_valid_time cart
    is_show = false
    if cart.product.Type == 5
      lh = LotteryHistory
               .where('UserID = ? and Type = ? and ObjectID = ? and CreateTime > ?  and OrderID is null', current_user.ID, 2, cart.product.ID, Time.now - 7.days)
               .order('CreateTime desc').first
      lh_time = lh.CreateTime + 7.days
      is_show = true if lh_time > Time.now
    else
      is_show = true if cart.product.ActivityEndTime && Time.now < cart.product.ActivityEndTime
    end

    is_show
  end

  # 活动商品剩余有效时间
  def valid_time cart
    if cart.product.Type == 5
      #获取最近一次抽奖记录
      lh = LotteryHistory
               .where('UserID = ? and Type = ? and ObjectID = ? and CreateTime > ?  and OrderID is null', current_user.ID, 2, cart.product.ID, Time.now - 7.days)
               .order('CreateTime desc').first
      lh_time = lh.CreateTime + 7.days
      # 抽奖商品剩余时间
      if (DateTime.parse(lh_time.strftime('%Y-%m-%d')) - DateTime.parse(Time.now.strftime('%Y-%m-%d'))).to_i == 0
        valid_time =((DateTime.parse(lh_time.strftime('%Y-%m-%d %H')) - DateTime.parse(Time.now.strftime('%Y-%m-%d %H')))*24).to_i.to_s + '小时'
      else
        valid_time =(DateTime.parse(lh_time.strftime('%Y-%m-%d')) - DateTime.parse(Time.now.strftime('%Y-%m-%d'))).to_i.to_s + '天'
      end

    else
      valid_time =((Time.parse(cart.product.ActivityEndTime.strftime("%Y-%m-%d %H")) - Time.parse(Time.now.strftime("%Y-%m-%d %H")))/(3600 * 24)).ceil.to_s + '天'
    end

    valid_time
  end


end

