class StockRandom

  def self.coupon_lottery
    @@coupon_pickup ||= Pickup.new({ "5" => 20, "10" => 74, "20" => 4, "50" => 2 })
    return @@coupon_pickup.pick.to_i
  end

  def self.new_user_coupon
    @@nu_coupon_pickup ||= Pickup.new({ "5" => 835, "10" => 150, "15" => 10, "20" => 5 })
    return @@nu_coupon_pickup.pick.to_i
  end

  def self.coupon_lottery_statistic num
    hash = {}
    num.times do |i|
      v = coupon_lottery.to_s
      if hash[v]
        hash[v] += 1
      else
        hash[v] = 1
      end
    end
    return hash
  end

  def self.new_user_coupon_statistic num
    hash = {}
    num.times do |i|
      v = new_user_coupon.to_s
      if hash[v]
        hash[v] += 1
      else
        hash[v] = 1
      end
    end
    return hash
  end

  def self.lottery option
    coupon_pickup = Pickup.new(option)
    return coupon_pickup.pick
  end

  def self.rand_num
    code = nil
    while !code or $redis.sismember("order_rand_num", code)
      code = ([*'a'..'z'] - ['l', 'o']).sample(1).join + [*'0'..'9'].sample(5).join
    end
    return code if $redis.sadd("order_rand_num", code)
  end
end
