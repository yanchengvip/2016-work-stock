class ActivityController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:show, :coupon_lottery, :new_year, :test, :women_s_day, :coupon_women_day, :hire2016, :weishu, :my_store, :survey, :father2016, :anniver_share_page, :anniver_wechat]
  skip_before_filter :set_area, only: [:show_new, :coupon_lottery, :coupon_women_day, :new_year, :hire2016, :weishu, :my_store, :survey, :father2016, :festival_lottery, :anniver_wechat, :anniver_share_page, :point_lottery_item]
  skip_before_filter :verify_authenticity_token, only:[:car_benefit_info, :survey, :golden_egg_lottery, :anniversary_lottery,:point_lottery_item,:point_lottery_reward]

  def rush_product
    @product = Product.find_by(ID: params[:product_id])
    status, message = current_user.rush_product(@product)
    if status
      render json: {status: 'ok',cart_for_nav: current_user.cart_for_nav(session[:depot_ids],session[:company_id]).first }
    else
      render json: {status: 'error', message: message || '操作失败'}
    end
  end

  def show
    depot_ids = DepotSendCounty.get_depots_by(session[:county_id])
    @recommend = ProductRecommendInfo.find_by(ID: params[:id])
    if @recommend.IsSeckill?
      @company_city = CompanyCity.find_by(CompanyID: session[:company_id], CityID: session[:city_id])
      products = @recommend.products.includes(:product_info, :group_products => [:sub_product => [:product_info]])
                            .where("ActivityBeginTime > ? and Products.State = 2", Date.today)
                            .order("ActivityBeginTime")
      @stocks = DepotProductStock.stocks_for(products.map(&:ID), depot_ids) if products
      @tomorrow_products, current_products, dated_products, future_products = [], [], [], []
      products.each do |product|
        if product.ActivityBeginTime > Date.tomorrow
          @tomorrow_products << product
        else
          if Time.now < product.ActivityBeginTime
            future_products << product
          elsif Time.now > product.ActivityEndTime or (Time.now > product.ActivityBeginTime - 1.hour and product.MaxActivityAmount == product.CurrentActivityAmount)
            dated_products << product
          else
            current_products << product
          end
        end
      end
      current_products.sort!{|p1, p2| p2.ActivityBeginTime <=> p1.ActivityBeginTime}
      @today_products = current_products | future_products | dated_products
      render 'rush'
    else
      #@products = @recommend.products.includes(:product_info)
      if @recommend.Template == 9
        #默认选中排序最小的楼层.楼层只取前10位
        # activity_floors= @recommend.activity_floors.includes(:products).order('activity_floor_products.Sort ASC',).order(Sort: :asc).limit(10)
        #楼层排序正确
        @activity_floors= @recommend.activity_floors.includes(:products).order(Sort: :asc).limit(10)
      elsif @recommend.Template == 10
        @activity_floors= @recommend.activity_floors.order("Sort").limit(10)
      else
        @products = @recommend.products.includes(:product_info, :sub_products => [:product_info])
                        .where("Products.State = 2 and (Products.ActivityBeginTime is null or (Products.ActivityBeginTime <= ? and Products.ActivityEndTime > ?))", Time.now, Time.now)
                        .order("ProductRecommendInfoDetails.OrderBy")
        @stocks = DepotProductStock.stocks_for(@products.map(&:ID), depot_ids) if @products
        @coupons = @recommend.coupons.select("Coupons.*, if(uc.UsersID is null, 0, 1) has_collect")
                       .joins("left join UserCoupons uc on uc.CouponID = Coupons.ID and uc.UsersID = '#{current_user.try(:ID)}'")
                       .where("(uc.ID is null or uc.Status = 1)")
      end

    end if @recommend
  end

  def new_year
    render layout: 'mobile_events'
  end

  def women_s_day
    render layout: 'mobile_events'
  end

  def test
    render layout: 'mobile_events'
  end

  def points_mall
  end

  def hire2016
    render layout: 'mobile_events'
  end

  def anniver_wechat
    render layout: 'mobile_events'
  end

  def weishu
    render layout: 'mobile_events'
  end

  def anniver_wechat
    render layout: 'mobile_events'
  end

  def my_store
    @tags = Array.new
    UserTag.where("GroupID is not null and GroupID <= 4").order(:OrderBy).each do |ut|
      @tags[ut.GroupID-1] = Array.new if !@tags[ut.GroupID-1]
      @tags[ut.GroupID-1] << ut.ID
    end
    render layout: 'mobile_events'
  end

  def coupon_lottery
    if (invitation = Invitation.find_by(Phone: params[:phone], TypeID: 1))
      render json: {status: 'error', message: '你已经参加过此活动', data: {coupon_price: invitation.CouponPrice}}
    else
      #coupon_price = StockRandom.coupon_lottery
      coupon_price = 10
      ActiveRecord::Base.transaction do
        Invitation.create(Phone: params[:phone], CouponPrice: coupon_price, UseMoney: 200, TypeID: 1, Remark: '优惠券抽奖')
        if (user = User.find_by(Phone: params[:phone]))
          user.coupons.create(Price: coupon_price, UseMoney: 200, Status: 1, EndDate: Date.today + 30.days - 1.second, Source: 0)
        end
      end
      render json: {status: 'ok', data: {coupon_price: coupon_price}}
    end
  end

  def coupon_women_day
    if (invitation = Invitation.find_by(Phone: params[:phone], TypeID: 2))
      render json: {status: 'error', message: '你已经参加过此活动', data: {coupon_price: invitation.CouponPrice}}
    else
      ActiveRecord::Base.transaction do
        Invitation.create(Phone: params[:phone], CouponPrice: 3, UseMoney: 1000, TypeID: 2, Remark: '妇女节')
        if (user = User.find_by(Phone: params[:phone]))
          user.coupons.create(Price: 3, UseMoney: 1000, Status: 1, EndDate: Date.today + 15.days - 1.second, Source: 0)
        end
      end
      render json: {status: 'ok'}
    end
  end

  # 购物车结账时显示的优惠
  def car_benefit_info
    money = params[:money]
    company_id = params[:company_id]
    @activities = Activity.active_benefit_info money,company_id

  end

  # 商铺调查
  def survey
    data = JSON.parse(params[:data])
    if data["tel"].present? and (user = User.find_by(Phone: data["tel"]))
      user.update_attributes(UserTagsID: data.except("tel").values.join(","))
    end
    $redis.lpush('store_survey', params[:data])
    render json:{status:'ok'}
  end

  #端午抽奖
  def festival_lottery
    key = current_user.ID+"_fest_lottery_number"
    num = $redis.get(key)#获取今天的抽奖次数
    if num.to_i >= 1
      @draw_result ={status:'error',message:'您已抽过奖'}
    else
      draw_result = PointLottery.festival_lucky_draw current_user.ID
      #draw_result = {"result":{"status":"ok","message":""},"point_lottery":{"id":3,"type":0,"type_name":"端午优惠券","percent":398,"points":0,"coupon_price":5.5,"user_money":1000,"days":15,"level":3}}
      expire_time  = (Time.parse((Time.now+1.day).strftime("%Y-%m-%d")) - Time.parse(Time.now.to_s))#秒
      $redis.set(key, num.to_i + 1)
      $redis.expire(key, expire_time.to_i)
      @draw_result = {status:'ok',message:'',point_lottery:draw_result[:point_lottery]}
    end
    render json:@draw_result
  end

  def lottery
    render 'activity/festival'
  end

  #周年庆
  def anniversary
    @recommend = ProductRecommendInfo.find_by(RecommendName: '进货宝1018周年庆主会场', CompanyID: session[:company_id])
    company = Company.find_by(ID: session[:company_id])
    redirect_to activity_path(@recommend) if company.CompanyNameCN.to_s =~ /湖南|内蒙/
    @pic_floors = @recommend.activity_floors.where(Pattern: 0).order("Sort").limit(6)
    @pro_floors = @recommend.activity_floors.where(Pattern: 1).order("Sort")
    @coupons = Coupon.birth_gift(session[:company_id])
  end

  def anniversary_lottery
=begin
    if $redis.get("#{current_user.ID}:anniversary_wheel")
      render json: {status: 'error', message: '今日已抽过奖，每日限一次'}
    elsif (coupons = Coupon.birth_wheel(session[:company_id])).size.in?([3,4])
      percent = {"1.02" => 730, "10.18" => 45, "101.8" => 3, "1018" => 0}
      lotteries = []
      coupons.each_with_index{|coupon, index| lotteries << {id: index, type: 0, type_name: '优惠券', percent: percent[coupon.CouponPrice.to_s], points: 0, obj_id: coupon.ID}}
      lotteries << {id: index, type: 0, type_name: '优惠券', percent: 0, points: 0, obj_id: nil} if coupons.size == 3
      lotteries << {id: 4, type: 1, type_name: '积分', percent: 20, points: 1018, obj_id: nil}
      lotteries << {id: 5, type: 1, type_name: '积分', percent: 2, points: 10180, obj_id: nil}
      lotteries << {id: 6, type: -1, type_name: '再接再厉', percent: 10, points: 0, obj_id: nil}
      lotteries << {id: 7, type: -1, type_name: '再接再厉', percent: 10, points: 0, obj_id: nil}
      gift_id = PointLottery.lottery_lucky_draw(current_user, session[:company_id], lotteries, "周年庆")
      if gift_id
        $redis.set("#{current_user.ID}:anniversary_wheel", 1)
        $redis.expire("#{current_user.ID}:anniversary_wheel", (Date.tomorrow.to_time - Time.now).to_i)
        render json: {status: 'ok', data: {gift_id: gift_id}}
      else
        render json: {status: 'error', message: '操作失败'}
      end
    else
      render json: {status: 'error', message: '内部错误'}
    end
=end
    lotteries = [
      {id: 0, type: 1, type_name: '积分', percent: 180, points: 15, obj_id: nil},
      {id: 1, type: 1, type_name: '积分', percent: 225, points: 30, obj_id: nil},
      {id: 2, type: 1, type_name: '积分', percent: 65, points: 400, obj_id: nil},
      {id: 3, type: 1, type_name: '积分', percent: 30, points: 1000, obj_id: nil},
      {id: 4, type:-1, type_name:'再接再厉', percent: 250, points:0, obj_id: nil},
      {id: 5, type:-1, type_name:'再接再厉', percent: 250, points:0, obj_id: nil}
    ]
    #if false
    if $redis.get("#{current_user.ID}:anniversary_wheel")
      render json: {status: 'error', message: '今日已抽过奖，每日限一次'}
    else
      gift_id = PointLottery.lottery_lucky_draw(current_user, session[:company_id], lotteries, "周年庆转盘")
      if gift_id
        $redis.set("#{current_user.ID}:anniversary_wheel", 1)
        $redis.expire("#{current_user.ID}:anniversary_wheel", (Date.tomorrow.to_time - Time.now).to_i)
        render json: {status: 'ok', data: {gift_id: gift_id[:id]}}
      else
        render json: {status: 'error', message: '操作失败'}
      end
    end
  end

  def golden_egg
    redirect_to root_path and return if !session[:company_id].in?(['22294f4c-dacc-48d6-aba8-d6c8fbe8cf7e', 'd1d929ec-3af1-45f3-8047-b9abd47e8de5'])
  end

  def golden_egg_screen
    lottery_histories = LotteryHistory.includes(:user).where("CreateTime > '2016-09-27' and PrizeName like '周年庆砸金蛋%'").order("CreateTime desc").limit(20)
    histories = lottery_histories.map{|lh| {tel: lh.user.Phone.gsub(/(\d{3})\d{4}/, '\1****'), prize: lh.PrizeName.split(/\-\-\-|进货宝/).last}}
    histories << {tel: "189****1055", prize: "1018代金券"}
    histories << {tel: "133****3178", prize: "港澳三日游"}
    #histories << {tel: "158****5318", prize: "乐视电视"}
    histories << {tel: "186****3054", prize: "苹果7"}
    render json: {status: 'ok', data: histories.sample(24)}
  end

  def golden_egg_lottery
    #if false
    render json: {status: 'error', message: '没有相关活动'} and return if !session[:company_id].in?(['22294f4c-dacc-48d6-aba8-d6c8fbe8cf7e', 'd1d929ec-3af1-45f3-8047-b9abd47e8de5'])
    if $redis.get("#{current_user.ID}:anniversary_egg")
      render json: {status: 'error', message: '今日已抽过奖，每日限一次'}
    elsif (coupons = Coupon.birth_egg(session[:company_id])).size.in?([2,3])
      percent = {"3" => 1000, "5" => 1000, "1018" => 0}
      lotteries = []
      coupons.each_with_index{|coupon, index| lotteries << {id: index, type: 0, type_name: '优惠券', percent: percent[coupon.CouponPrice.to_s], points: 0, obj_id: coupon.ID}}
      lotteries << {id: 2, type: 0, type_name: '优惠券', percent: 0, points: 0, obj_id: nil} if coupons.size == 2
      hash = {"22294f4c-dacc-48d6-aba8-d6c8fbe8cf7e" => "ZP20161013006", "d1d929ec-3af1-45f3-8047-b9abd47e8de5" => "ZP20161016005"}
      product = Product.find_by(Code: hash[session[:company_id]], Type: 4)
      lotteries << {id: 3, type: 2, type_name: "商品", percent: 20, points: 0, obj_id: product.ID}
      lotteries << {id: 4, type: 3, type_name: '港澳三日游', percent: 0, points: 0, obj_id: nil}
      #date = Date.parse '2016-10-18'
      #per = if Time.now < date or Time.now > date.tomorrow or $redis.get("anniversary_egg:tv").to_i >= 2 then 0 else 2 end
      per = 0
      lotteries << {id: 5, type: 3, type_name: '乐视电视机', percent: per, points: 0, obj_id: nil}
      lotteries << {id: 6, type: -1, type_name: '苹果7', percent: 0, points: 0, obj_id: nil}
      lotteries << {id: 7, type: -1, type_name: '再接再厉', percent: 968, points: 0, obj_id: nil}
      gift_id = PointLottery.lottery_lucky_draw(current_user, session[:company_id], lotteries, "周年庆砸金蛋")
      if gift_id
        $redis.set("#{current_user.ID}:anniversary_egg", 1)
        $redis.expire("#{current_user.ID}:anniversary_egg", (Date.tomorrow.to_time - Time.now).to_i)
        render json: {status: 'ok', data: {gift_id: gift_id[:id]}}
      else
        render json: {status: 'error', message: '操作失败'}
      end
    else
      render json: {status: 'error', message: '内部错误'}
    end
  end

  def golden_egg_history
    @lottery_history_items = LotteryHistory.where("UserID = ? and PrizeName like '周年庆砸金蛋%'", current_user.ID).order('CreateTime desc')
  end

  # 转盘抽奖列表 后台配置抽奖比例
  def point_lottery_item
    addresses = current_user.addresses.where(IsDefault: true,IsDeleted: false).first
    county_id = addresses.present? ?  addresses.CountyID : ''
    company_depot = DepotSendCounty.get_company_depot_by county_id
    if company_depot.present?
      company_id = company_depot[:company_id]
      depot_id = company_depot[:depot_id]
      @point_lotteries = PointLottery.includes(:coupon,:product).where(DepotID: depot_id,Type: [0,1,2,4]).order(Level: :asc).limit(8)
    else
      @point_lotteries = []
    end

  end
  # 转盘抽奖
  def point_lottery_reward
    key = current_user.ID+"_lottery_number"
    num = $redis.get(key) #获取今天的抽奖次数
    if  num.to_i >= 1
      @draw_result ={status: 'error', message: '您今天抽奖次数已达到1次，不能继续抽奖'}
    else
      draw_result = PointLottery.lucky_draw current_user
      if draw_result.present?
        @point_lottery = PointLottery.includes(:coupon,:product).find(draw_result[:point_lottery_id])
        expire_time = (Time.parse((Time.now+1.day).strftime("%Y-%m-%d")) - Time.parse(Time.now.to_s)) #秒
        $redis.set(key, num.to_i + 1)
        $redis.expire(key, expire_time.to_i)
      end
    end
  end
end
