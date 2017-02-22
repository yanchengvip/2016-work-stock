=begin
  create_table "PointLotteries", primary_key: "ID", force: :cascade do |t|
    t.integer  "Type",        limit: 4
    t.string   "TypeName",    limit: 255
    t.integer  "Percent",     limit: 4
    t.integer  "Points",      limit: 4
    t.decimal  "CouponPrice",             precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
  end
=end

# Type 0=优惠券,1=积分,2=产品,3=乐视电视,4=无奖励

class PointLottery < ActiveRecord::Base
  self.table_name = 'PointLotteries'
  belongs_to :coupon, foreign_key: 'CouponID'
  belongs_to :product, foreign_key: 'ProductID'


  # 转盘抽奖
  def self.lucky_draw user
    point_lottery_items = []
    addresses = user.addresses.where(IsDefault: true, IsDeleted: false).first
    county_id = addresses.present? ? addresses.CountyID : ''
    company_depot = DepotSendCounty.get_company_depot_by county_id
    depot_id = company_depot[:depot_id]
    point_lotteries = PointLottery.includes(:coupon, :product).where(DepotID: depot_id, Type: [0, 1, 2, 4]).order(Level: :asc).limit(8)
    num = 0
    point_lotteries.each_with_index do |pl, index|
      case pl.Type
        when 0
          #优惠券
          point_lottery_items << {id: num, point_lottery_id: pl.ID, type: pl.Type, type_name: pl.TypeName, percent: pl.Percent.to_f,
                                  points: pl.Points.to_i, obj_id: pl.CouponID,depot_id: depot_id}
          num += 1
        when 1
          #积分
          point_lottery_items << {id: num, point_lottery_id: pl.ID, type: pl.Type, type_name: pl.TypeName, percent: pl.Percent.to_f,
                                  points: pl.Points.to_i, obj_id: pl.ID,depot_id: depot_id}
          num += 1
        when 2
          #产品，只能抽所在地区的仓库产品
          dps = DepotProductStock.where(DepotID: pl.DepotID, ProductID: pl.ProductID).first
          if dps.ActivityNum > 0
            #有库存
            point_lottery_items << {id: num, point_lottery_id: pl.ID, type: pl.Type, type_name: pl.TypeName, percent: pl.Percent.to_f,
                                    points: pl.Points.to_i, obj_id: pl.ProductID, depot_id: depot_id}
            num += 1
          end
        when 4
          #无奖励
          point_lottery_items << {id: num, point_lottery_id: pl.ID, type: pl.Type, type_name: pl.TypeName, percent: pl.Percent.to_f,
                                  points: pl.Points.to_i, obj_id: pl.ID,depot_id: depot_id}
          num += 1
      end

    end
    lottery_lucky_draw user, nil, point_lottery_items
  end


=begin
    # id 从0开始
    lotteries =  [
        {id:0, type:0,  type_name:'优惠券',   percent:5,  points:0,   obj_id:10},
        {id:1, type:0,  type_name:'优惠券',   percent:10, points:0,   obj_id:10},
        {id:2, type:1,  type_name:'积分',     percent:20, points:20,  obj_id:0},
        {id:3, type:1,  type_name:'积分',     percent:15, points:20,  obj_id:0},
        {id:4, type:-1, type_name:'再接再厉', percent:0,  points:0,   obj_id:0},
    ]
=end
  def self.lottery_lucky_draw user, company_id, lotteries, mark=nil
    options = Hash[lotteries.map { |l| [l[:id], l[:percent]] }]
    lottery = lotteries[StockRandom.lottery options]
    flag = false
    ActiveRecord::Base.transaction do
      if lottery[:type] == 0
        #赠送 优惠现金券
        coupon = Coupon.find_by(ID: lottery[:obj_id])
        user_coupon = UserCoupon.create!(UsersID: user.ID, CouponID: coupon.ID, Price: coupon.CouponPrice, Status: 1, Type: coupon.CouponType, Source: 0,
                           UseMoney: coupon.ActivityPrice, StartDate: Date.today, EndDate: Date.today + coupon.CouponDays.to_i - 1.second, Cause: '转盘抽奖')
        LotteryHistory.create!(UserID: user.ID, Type: 0, ObjectID: coupon.ID,DepotID: lottery[:depot_id],UserCouponID: user_coupon.ID, PrizeName: [mark, "进货宝#{coupon.CouponPrice}元优惠券"].compact.join('---'))
      elsif lottery[:type] == 1
        #赠送 积分
        user.increment_with_sql!(:Integral, lottery[:points])
        LotteryHistory.create!(UserID: user.ID, Type: 1,DepotID: lottery[:depot_id], PrizeName: [mark, "进货宝#{lottery[:points]}积分"].compact.join('---'))
        PointHistory.create!(UserID: user.ID, CurrentPoint: user.Integral.to_i, DeltaPoint: lottery[:points], Type: 4)
      elsif lottery[:type] == 2
        #赠送 商品
        dps = DepotProductStock.where(DepotID: lottery[:depot_id], ProductID: lottery[:obj_id]).first.lock!
        if dps.ActivityNum <= 0
          #库存不足，重新抽奖
          return lucky_draw user
        end
        dps.increment_with_sql!(:ActivityNum, -1)
        product = Product.find_by(ID: lottery[:obj_id])
        LotteryHistory.create!(UserID: user.ID, Type: 2, ObjectID: lottery[:obj_id],DepotID: lottery[:depot_id], PrizeName: [mark, "进货宝#{product.Name}"].compact.join('---'))
        cart = Cart.find_by(UserID: user.ID, ProductID: product.ID)
        if cart
          cart.update_attributes!(Number: cart.Number + 1)
        else
          user.carts.create!(ProductID: product.ID, CompanyID: product.CompanyID, ThirdType: product.ThirdType, Number: 1)
        end
      elsif lottery[:type] == 3 and lottery[:type_name] == "乐视电视机"
        $redis.incr("anniversary_egg:tv")
        LotteryHistory.create!(UserID: user.ID, Type: 3, PrizeName: [mark, lottery[:type_name]].compact.join('---'))
      elsif lottery[:type] == 4
        LotteryHistory.create!(UserID: user.ID, Type: 4,DepotID: lottery[:depot_id], PrizeName: "再接再厉")
      end

      flag = true
    end
    return lottery if flag
    return nil
  end


  # 中秋节日概率抽奖
  # 一等奖：0%,二等奖：0.02%,三等奖：3.98%,四等奖:40%,五等奖:40%,六等奖：16%
  def self.festival_lucky_draw user_id
    point_lotteries = [
        {id: 1, type: 0, type_name: '优惠券', percent: 5, points: 0, coupon_price: 10, user_money: 500, days: 7, level: 1},
        {id: 2, type: 0, type_name: '优惠券', percent: 10, points: 0, coupon_price: 10, user_money: 500, days: 7, level: 5},
        {id: 3, type: 0, type_name: '优惠券', percent: 30, points: 0, coupon_price: 2, user_money: 500, days: 7, level: 3},
        {id: 4, type: 1, type_name: '积分', percent: 20, points: 20, coupon_price: 0, user_money: 0, days: 0, level: 4},
        {id: 5, type: 1, type_name: '积分', percent: 20, points: 20, coupon_price: 0, user_money: 0, days: 0, level: 6},
        {id: 6, type: 1, type_name: '积分', percent: 15, points: 20, coupon_price: 0, user_money: 0, days: 0, level: 5},
        {id: 7, type: -1, type_name: '再接再厉', percent: 0, points: 0, coupon_price: 0, user_money: 0, days: 3, level: 2},
        {id: 8, type: -1, type_name: '再接再厉', percent: 0, points: 0, coupon_price: 0, user_money: 0, days: 0, level: 6}
    ]
    #中奖概率基数
    num = 100
    if !point_lotteries.empty?
      point_lotteries.each do |pl|
        lottery_num = rand(1..num)
        if lottery_num <= pl[:percent]
          @point_lottery = pl
          break
        else
          #假设当前奖项第6次,percent=30%,lottery_num>30则没中六等奖,前五次循环都没中则总获奖基数 num = 100-1-2-18-19-30=30,必中6等奖
          num -= pl[:percent]
        end
      end

      options = {
          user_id: user_id,
          del_point: 0,
          is_festival: true,
          type: @point_lottery[:type],
          add_point: @point_lottery[:points],
          coupon_price: @point_lottery[:coupon_price],
          use_money: @point_lottery[:user_money],
          days: @point_lottery[:days]
      }
      result =PointHistory.new.exchange_point options
      data = {result: result, point_lottery: {id: @point_lottery[:id], points: @point_lottery[:points], coupon_price: @point_lottery[:coupon_price], type_name: @point_lottery[:type_name]}}
    else
      data = {result: {status: 'error', message: '抽奖无效，请联系客服添加奖品'}}
    end

    return data
  end
end
