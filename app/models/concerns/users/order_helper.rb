module Users
  module OrderHelper
    extend ActiveSupport::Concern

    included do
      has_many :orders, -> { order("CreateTime desc") }, :foreign_key => "UserID"
      has_many :order_groups, -> { order("CreateTime desc") }, :foreign_key => "UserID"
      has_many :app_orders, -> { where("OrderStatus is not null and OrderStatus != -1 and FromPlatform = 'app'") }, foreign_key: 'UserID', class_name: 'Order'
    end

    def cart_to_orders(list, opt={})
      list.select! { |li| li["number"].to_i > 0 }
      product_ids = list.map { |item| item["key"] }
      products = Product.includes(:sub_products, :product_info).where(ID: product_ids)
      return false, '没有找到对应商品' if products.blank?
      products_hash = Hash[products.map { |p| [p.ID, p] }]

      list_group = Hash.new

      #检查购买数量及是否下架
      product_stocks = DepotProductStock.where(DepotID: opt[:depot_ids], ProductID: product_ids)
      product_stocks_hash = Hash[product_stocks.map { |ps| [ps.ProductID, ps] }]
      tbuys = self.today_buys
      list.each do |item|
        product = products_hash[item["key"]]
        if product
          if Company.need_stock?(product.CompanyID)
            return false, "#{product.Name} 已下架" if product.State != 2 or !product_stocks_hash[product.ID] or product_stocks_hash[product.ID].State != 2
          else
            return false, "#{product.Name} 已下架" if product.State != 2 or product.SellState != 2
          end
          if self.IsLimitBuy
            #return false, "#{product.Name} 每次购买数量不能超过 #{product.MaxSaleAmount} 件" if item["number"].to_i > product.MaxSaleAmount
            return false, "#{product.Name} 不能少于 #{product.MinBuyCount.to_i}件最小起定量" if item["number"].to_i < product.MinBuyCount.to_i
            if product.MaxSaleAmountDay.present? && item["number"].to_i + tbuys[product.ID].to_i > product.MaxSaleAmountDay
              return false, "#{product.Name} 每天购买数量不能超过 #{product.MaxSaleAmountDay} 件，今天已经购买 #{tbuys[product.ID]} 件"
            end
          end
          list_group[product.CompanyID] = Array.new if !list_group[product.CompanyID]
          list_group[product.CompanyID] << item
        end
      end

      platform = opt[:from_app] ? 'app' : CommonHelper.from_platform(opt[:user_agent])

      status, message, order_group, has_privilege = false, nil, nil, true
      #is_verified = self.addresses.joins(:store_information).where("storeinformations.Status = 2").count > 0
      #has_privilege = self.orders.where("PayDatetime is not null").count == 0 if !is_verified
      has_privilege = true
      ActiveRecord::Base.transaction do
        order_group = OrderGroup.create!(UserID: self.ID)
        option = {platform: platform, order_group_id: order_group.ID, city_id: opt[:city_id], depot_ids: opt[:depot_ids], has_privilege: has_privilege}
        list_group.each do |company_id, item_list|
          order, message = cart_to_order(item_list, products_hash, company_id, option)
          raise ActiveRecord::Rollback if !order
        end
        status = true
      end if list_group.present?
      order_group = nil if !status
      return order_group, message
    end

    def cart_to_order(list, products_hash, company_id, option)
      platform, order_group_id = option[:platform], option[:order_group_id]

      order, rate, giveaway, status, activities = nil, 1, 0, false, []
      total_price, need_discount = calculate_price(list, products_hash)

      #检查起送金额及SKU数量
      company_city = CompanyCity.find_by(CompanyID: company_id, CityID: option[:city_id])
      send_price, sku_count = company_city.try(:SendPrice).to_i, company_city.try(:SkuCount).to_i
      return false, "#{company_city.company.show_name}订单金额不足#{send_price}元" if total_price.round(2) < send_price
      p_count = list.inject(0) { |sum, item| sum + (products_hash[item["key"]].Type == 1 ? products_hash[item["key"]].sub_products.count : 1) }
      return false, "#{company_city.company.show_name}订单商品需#{sku_count}种以上" if self.IsLimitBuy and p_count < sku_count

      #满足条件的活动
      if option[:has_privilege]
        activities = Activity.related_activities(total_price.round(2), company_id, option[:city_id])
        if activities[3] and activities[3].ActivityPurpose.to_s.downcase.include?(platform) #满折
          rate = activities[3].Discount
          giveaway += (need_discount * (1 - rate)).round(2)
        end
        if activities[2] and activities[2].ActivityPurpose.to_s.downcase.include?(platform) #满减
          giveaway += (activities[2].SubPrice).round(2)
        end
      end
      money = (total_price - giveaway).round(2)
      ActiveRecord::Base.transaction do
        order = self.orders.create!(OrderCode: CommonHelper.get_order_code, ShipStatus: 0, PayStatus: 0, Discount: rate, GiveawayTotal: giveaway, Money: money, OriginalMoney: money,
                                    CostItem: total_price.round(2), FromPlatform: platform, CompanyID: company_id, RandNum: StockRandom.rand_num, OrderGroupID: order_group_id)
        list.each do |item|
          product = products_hash[item["key"]]
          if product and item["number"].to_i > 0
            item_rate = product.Type == 2 ? 1 : rate
            order.order_products.create!(Quantity: item["number"].to_i, ProductID: item["key"], Price: product.ProductPrice,
                                         DiscountPrice: (product.ProductPrice * item_rate).round(2), ProductName: product.Name,
                                         ProductCode: product.Code, SMCommissionCoefficient: product.SMCommissionCoefficient)
          end
        end
        #满赠
        if activities[4] and activities[4].ActivityPurpose.to_s.downcase.include?(platform)
          act_products = activities[4].activity_products
          #product_stocks = DepotProductStock.where(DepotID: option[:depot_ids], ProductID: act_products.map(&:ProductID)).lock
          #product_stocks_hash = Hash[product_stocks.map { |ps| [ps.ProductID, ps] }]
          act_products.each do |a_product|
            #if product_stocks_hash[a_product.ProductID].try(:Stock).to_i >= a_product.GiftNumber.to_i
              order.order_products.create!(Quantity: a_product.GiftNumber, ProductID: a_product.ProductID, Price: 0, DiscountPrice: 0, ProductName: a_product.ProductName,
                                           ProductCode: a_product.ProductCode, SMCommissionCoefficient: 0)
            #end
          end
        end
        order.order_products.includes(:product).each do |order_product|
          product = order_product.product
          item_rate = product.Type == 2 ? 1 : order.Discount
          product.group_products.includes(:sub_product => [:product_info]).each do |group_product|
            order_product.order_group_products.create!(OrderID: order.ID, ProductID: product.ID, SubProductID: group_product.SubProductID,
                                                       Price: group_product.SubProductPrice, DiscountPrice: (group_product.SubProductPrice * item_rate).round(2),
                                                       Quantity: group_product.Number.to_i * order_product.Quantity, ProductName: group_product.sub_product.Name,
                                                       ProductCode: group_product.sub_product.Code)
          end if product.Type != 0
        end
        #activity_gift(order, activities[4], option) if activities[4]
        status = true
      end
      order = nil if !status
      return order
    end

    def activity_gift(order, acts, option)
      order_money = order.CostItem.round(2)
      product_count = Hash.new
      acts.each do |activity|
        num = 0
        while order_money >= activity.ActivityPrice
          order_money -= activity.ActivityPrice
          num += 1
        end
        if num > 0 and activity.ActivityPurpose.to_s.downcase.include?(option[:platform])
          activity.activity_products.each do |a_product|
            product_count[a_product.ProductID] = product_count[a_product.ProductID].to_i + a_product.GiftNumber.to_i * num
          end
        end
      end
      product_stocks = DepotProductStock.where(DepotID: option[:depot_ids], ProductID: product_count.keys).lock
      product_stocks_hash = Hash[product_stocks.map { |ps| [ps.ProductID, ps] }]
      Product.includes(:product_info).where(ID: product_count.keys).each do |product|
        if product_stocks_hash[product.ID].try(:Stock).to_i >= product_count[product.ID].to_i
          order.order_products.create!(Quantity: product_count[product.ID].to_i, ProductID: product.ID, Price: 0, DiscountPrice: 0, ProductName: product.Name,
                                       ProductCode: product.Code, SMCommissionCoefficient: 0)
        end
      end
    end

    def calculate_price list, products_hash
      total_price, need_discount = 0, 0
      list.each do |item|
        if products_hash[item["key"]]
          total_price += (item["number"].to_i * products_hash[item["key"]].ProductPrice.to_f)
          need_discount += (item["number"].to_i * products_hash[item["key"]].ProductPrice.to_f) if products_hash[item["key"]].Type != 2
        end
      end
      return total_price, need_discount
    end

    def confirm_orders order_group, attrs, diff_attrs, opt={}
      status, message = true, nil
      ActiveRecord::Base.transaction do
        order_group.update_attributes!(Status: 1)
        order_group.orders.each do |order|
          #least_order_money = Settings.order_money[order.CompanyID] || 150
          #status, message = false, "#{order.third_name}订单金额不足#{least_order_money}元" if order.CostItem.round(2) < least_order_money
          #raise ActiveRecord::Rollback if !status
          order_attrs = attrs.deep_dup
          if diff_attrs and (o_attrs = diff_attrs[order.ID])
            order_attrs.merge!(o_attrs.slice(:Message, :CouponCode, :Integral, :InvitationCode, :DeliveryDate, :DeliveryTime, :CashVolume))
          end
          # binding.pry
          status, message = confirm_order(order, order_attrs, opt)
          raise ActiveRecord::Rollback if !status
        end
      end
      return status, message
    end

    def confirm_order order, attrs, opt={}
      coupons, depot_id, county_id, face_name = nil, nil, nil, nil

      # 获取区域ID和仓库ID
      order_address = self.addresses.find_by(ID: opt[:address_id])
      if order_address.present?
        depot_send_county = DepotSendCounty.joins("inner join Depots d on d.ID = DepotSendCounties.DepotID").where("CountyID = ? and CompanyID = ?", order_address.CountyID, order.CompanyID).first
        if depot_send_county.present?
          depot_id = depot_send_county.DepotID
        else
          return false, "该地址不在配送区域内"
        end
        county_id = order_address.CountyID
        face_name = order_address.FaceName
      else
        return false, "该地址不存在"
      end

      #检查价格
      status, message = order.check_price
      return status, message if !status

      #检查优惠券
      coupons = UserCoupon.where(ID: attrs[:CouponCode].to_s.split(','))
      status, message = check_coupons(coupons)
      return status, message if !status
      coupons.each do |coupon|
        status, message = coupon.can_use_in?(order)
        return status, message if !status
      end
      attrs.delete(:CouponCode)

      #属性设置
      attrs.merge!(OpenedInovie: false, SubmitDate: Time.now, DepotId: depot_id, CountyID: county_id, FaceName: face_name)
      if attrs.key?(:PayType) and attrs[:PayType].to_s.include?('2')
        discouont = 0
        #优惠券
        coupon_price = 0
        coupons.each do |coupon|
          coupon.set_discount_money(order)
          discouont += coupon.discount_money
          coupon_price += coupon.discount_money
        end
        attrs.merge!(CouponPrice: coupon_price) if coupon_price > 0
        #App下单减10
        #from_app = order.FromPlatform == 'app'
        #discouont += 10 if from_app
        #attrs.merge!(AppDiscount: 10) if from_app
        #积分
        # if (integral = attrs[:Integral].to_i) > 0
        #   return false, '积分不足' if integral > self.Integral.to_i
        #   return false, '最多只能使用20000积分' if integral > 20000
        #   return false, '积分抵扣不能高于优惠后订单金额' if (integral/200) > (order.Money - discouont)
        #   point_price = integral.fdiv(200).round(2)
        #   discouont += point_price
        #   attrs.merge!(PointPrice: point_price)
        # end

        # attrs[:CashVolume] = attrs[:CashVolume].to_f * 200
        # if (attrs[:CashVolume] && (cash_volume = attrs[:CashVolume].to_d) > 0)
        if (attrs[:CashVolume] && (cash_volume = attrs[:CashVolume].to_f) > 0)
          return false, '现金卷不足' if cash_volume > self.CashVolume
          return false, '现金卷抵扣不能高于优惠后订单金额' if (cash_volume) > (order.Money - discouont)
          discouont += cash_volume
          # attrs.merge!(PointPrice: cash_volume)
        end

        order_status = Company.need_stock?(order.CompanyID) ? 1 : 10
        attrs.merge!(Money: (order.Money - discouont).round(2), OrderStatus: order_status, PayDatetime: Time.now)
      end

      #更新数据
      ActiveRecord::Base.transaction do
        order.update_attributes!(attrs)
        if attrs.key?(:PayType) and attrs[:PayType].to_s.include?('2')
          coupons.each do |coupon|
            coupon.lock!
            coupon.update_attributes!(IsRead: 1, CurrentCount: coupon.CurrentCount - 1)
            OrderCoupon.create!(OrderID: order.ID, UserID: self.ID, UserCouponID: coupon.ID, CouponID: coupon.CouponID, CouponPrice: coupon.discount_money)
            # 抽奖的优惠券历史操作
            LotteryHistory.coupon_set_order_id coupon, order
          end

          # if attrs[:Integral] and attrs[:Integral].to_i > 0
          #   self.increment_with_sql!(:Integral, -integral.to_i)
          #   self.point_histories.create!(CurrentPoint: self.Integral, DeltaPoint: -integral, Type: 5, OrderID: order.ID)
          #   binding.pry
          # end

          if attrs[:CashVolume]
            self.increment_with_sql!(:CashVolume, -cash_volume)
            self.cash_volume_histories.create!(CurrentCash: self.CashVolume, DeltaCash: -cash_volume, Type: 1, OrderID: order.ID)
            # self.point_histories.create!(CurrentPoint: self.CashVolume * 200, DeltaPoint: -cash_volume*200, Type: 5, OrderID: order.ID)
          end

          status, message = order.update_stock opt.merge(address_company_id: order_address.CompanyID)
          raise ActiveRecord::Rollback if !status
          OrderLog.create(OrderId: order.id, LogType: 1, OrderLogType: 1, OperationDate: Time.now, IP: opt[:user_ip], Agent: opt[:user_agent])
        end
        carts = Cart.where(UserID: self.ID, ProductID: order.order_products.map(&:ProductID))
        self.cart_hash.delete(*carts.map(&:ProductID))
        carts.delete_all
        order.set_buy_count
        order.auto_replenish_stock if Company.need_stock?(order.CompanyID)
        # 抽奖赠品记录历史操作
        LotteryHistory.product_set_order_id self, order

      end
      return status, message
    end

    def check_coupons coupons
      types = Hash.new
      coupons.each do |coupon|
        type = coupon.coupon.CouponType < 5 ? 0 : coupon.coupon.CouponType
        return false, "同类优惠券只能使用一张" if types[type]
        types[type] = true
      end
      return true
    end

    def back_to_cart order
      order.order_products.delete_all
      order.destroy
    end

    def buy_again order
      order_products = order.order_products.includes(:product)
      carts = Hash[Cart.where(UserID: self.id, ProductID: order_products.map(&:ProductID)).map { |cart| [cart.ProductID, cart] }]
      ActiveRecord::Base.transaction do
        self.carts.update_all(is_checked: false)
        order_products.each do |op|
          if (cart = carts[op.ProductID])
            cart.update_attributes(is_checked: true, Number: op.Quantity)
          else
            Cart.create(UserID: self.id, ProductID: op.ProductID, Number: op.Quantity, CompanyID: order.CompanyID, ThirdType: order.ThirdType)
          end if op.product.Type != 2 && op.product.Type != 4
        end
      end
    end

    def first_order_on_app?(user_agent)
      user_agent.include?('JinHuoBao') and self.orders.where("AppDiscount > 0 and OrderStatus not in (-1,0,6)").count == 0
    end

    def cancel_order order, reason, opt={}
      return false, "该订单不可以取消" if !order.OrderStatus.in?([1, 2, 7, 10])
      return false, "该订单取消申请中" if order.CanceledStatus == 1
      return false, "该订单已经被取消" if order.CanceledStatus == 2
      return false, "该订单已经被处理" if order.CanceledStatus == 3
      flag = false, message = nil
      ActiveRecord::Base.transaction do
        order_status = order.OrderStatus.in?([1, 10]) ? -1 : order.OrderStatus
        cancel_status = order.OrderStatus.in?([1, 10]) ? 2 : 1
        order_log_type = order.OrderStatus.in?([1, 10]) ? 21 : 20
        order.update_attributes!(OrderStatus: order_status, CanceledStatus: cancel_status)
        OrderLog.create!(OrderId: order.ID, Remark: reason, LogType: order.OrderStatus, OrderLogType: order_log_type, OperationDate: Time.now, IP: opt[:user_ip], Agent: opt[:user_agent])
        if order.OrderStatus == -1
          flag = order.cancel opt
          raise ActiveRecord::Rollback if !flag
        else
          phones = OrderCancelManager.where(DepotID: order.DepotId).map(&:Phone).compact
          AliDayu.sms_send(phones.join(','), {name: order.depot.Name, number: order.OrderCode}, 'SMS_33245433', '进货宝') if phones.present?
        end
        flag = true
        message = order.OrderStatus == -1 ? "取消成功" : "主人, 进货宝小二正在处理, 耐心等待哦~"

        #取消订单调用进货团
        User.order_cancle_to_jht order


      end
      return flag, message
    end


  end

  private

  def User.order_cancle_to_jht order
    #订单取消,调用进货团接口操作
    city = County.find(order.CountyID).city
    if city && order.OrderStatus.to_i == -1
      products = []
      order.order_products.each do |op|
        products.push({
                          ProductID: op.ProductID,
                          ProductInfoID: op.product.product_info.ID,
                          ProductName: op.ProductName,
                          ProductPrice: op.Price,
                          Quantity: op.Quantity,
                          ReturnNumber: op.RetrunNumber
                      })
      end
      params = {
          data: {
              BelongCityID: city.ID,
              CostItem: order.CostItem,
              From: "0",
              OrderCode: order.OrderCode,
              OrderID: order.ID,
              OrderStatus: -1,
              RecordTime: Time.now,
              products: products
          }
      }

      response = HTTParty.post(Settings.jht_order_cancle,
                               body: params.to_json,
                               headers: {'Content-Type' => 'application/json'})
      JSON.parse(response.body)
    end
  end
end
