# == Schema Information
#
# Table name: Orders
#
#  ID                 :string(36)       default(""), not null, primary key
#  OrderCode          :string(255)
#  Message            :string(255)
#  Address            :string(255)
#  MemberCode         :string(255)
#  CostItem           :decimal(18, 2)
#  GiveawayTotal      :decimal(18, 2)
#  PayDatetime        :datetime
#  OrderStatus        :integer
#  ShipStatus         :integer
#  LogiName           :string(255)
#  LogiCode           :string(255)
#  LogiPrice          :decimal(18, 2)
#  ShipName           :string(255)
#  ShipTel            :string(255)
#  PayStatus          :integer
#  Money              :decimal(18, 2)
#  PointPrice         :decimal(18, 2)
#  PayType            :integer
#  DepotId            :string(36)
#  IsHaveInvoice      :boolean
#  InvoiceTitle       :string(255)
#  OpenedInovie       :boolean
#  ReceivedPrice      :decimal(18, 2)
#  CreateTime         :datetime
#  CreateBy           :string(100)
#  UpdateTime         :datetime
#  UpdateBy           :string(100)
#  UserID             :string(36)
#  ReceivePriceType   :string(255)
#  ReceivePriceRemark :text(4294967295)
#  CouponCode         :string(36)
#  CouponPrice        :decimal(18, 2)
#  IsUrgency          :boolean
#  DriverName         :string(255)
#  DriverMobile       :string(255)
#  IsHaveReturn       :boolean
#  Discount           :decimal(18, 2)
#  SubmitDate         :datetime
#  CountyID           :string(36)
#

class Order < ActiveRecord::Base
  self.table_name = 'Orders'
  include UUIDHelper

  belongs_to :user, :foreign_key => "UserID"
  belongs_to :company, :foreign_key => "CompanyID"
  belongs_to :salesman, :foreign_key => "SalesmanID"
  belongs_to :depot, :foreign_key => "DepotId"
  has_many :order_products, :foreign_key => "OrderID"
  has_many :order_logs, -> { order("OperationDate desc") }, :foreign_key => "OrderId"
  has_many :order_coupons, :foreign_key => "OrderID"
  has_one :order_score, foreign_key: 'OrderID'
  has_many :products,through: :order_products, :foreign_key => "ProductID"
  before_save :set_salesman, if: Proc.new{|order| order.InvitationCode.present?}
  before_save :set_delivery_time, if: Proc.new{|order| order.DeliveryTime_changed? and order.DeliveryTime.present?}
  before_destroy :delete_order_products
  attr_accessor :product_hash, :group_hash, :company_hash, :brand_hash, :Integral


  def to_param
    self.OrderCode
  end

  def third_name
    case self.company.ThirdType
      when 0
        "进货宝自营"
      else
        self.company.CompanyNameCN
    end
  end

  def data platform=nil
    total_price, need_discount, giveaway = 0, 0, 0
    self.order_products.includes(:product).each do |op|
      total_price += op.Quantity.to_i * op.product.ProductPrice.to_f
      need_discount += op.Quantity.to_i * op.product.ProductPrice.to_f if op.product.Type != 2
    end
    total_price = total_price.round(2)
    if platform != 'pc'
      rate = total_price >= 500 ? (total_price < 1000 ? 0.93 : 0.9) : 1
      giveaway = (need_discount * (1 - rate)).round(2)
    end
    return total_price, giveaway, rate
  end

  def update_money platform
    # todo rate
    total_price, giveaway = self.data(platform)
    ActiveRecord::Base.transaction do
      self.update_attributes(Discount: rate, GiveawayTotal: giveaway.round(2), Money: (total_price - giveaway).round(2), FromPlatform: platform)
      OrderProduct.where(OrderID: self.ID).update_all("DiscountPrice = Price * #{rate}")
    end
  end

  def update_stock opt={}
    status, message, order_is_pre = true, nil, false
    stock_company_id = self.company.ThirdType == 3 ? self.CompanyID : opt[:address_company_id]
    ActiveRecord::Base.transaction(requires_new: true) do
      product_stocks = DepotProductStock.where(DepotID: self.DepotId, ProductID: order_products.map(&:ProductID)).lock
      if product_stocks.blank?
        status, message = false, "库存不足"
        raise ActiveRecord::Rollback
      end
      product_stocks_hash = Hash[product_stocks.map { |ps| [ps.ProductID, ps] }]
      self.order_products.includes(:product).each do |op|
        if op.product.State != 2 or product_stocks_hash[op.ProductID].try(:State).to_i != 2
          status, message = false, "#{op.product.Name} 已下架"
          raise ActiveRecord::Rollback
        end
        stock = product_stocks_hash[op.ProductID].try(:Stock).to_i + product_stocks_hash[op.ProductID].try(:PreSaleQuantity).to_i
        if op.Quantity > stock
          status, message = false, "#{op.product.Name} 库存不足"
          raise ActiveRecord::Rollback
        end
        is_pre = op.Quantity > product_stocks_hash[op.ProductID].try(:Stock).to_i
        if is_pre
          order_is_pre = true
          op.update_attributes!(IsPreSale: true)
        end
        ProductStockLog.create!(DataID: self.id, ProductCode: op.product.Code, ProductName: op.product.Name, ChangeNumber: -op.Quantity.to_i,
                                Unit: op.product.Unit, ChangeType: 1, IP: opt[:user_ip], Agent: opt[:user_agent], DataDetailID: op.id,
                                ProductID: op.ProductID, BeforeNumber: product_stocks_hash[op.ProductID].Stock, DepotID: self.DepotId)
        product_stocks_hash[op.ProductID].increment_with_sql!(:Stock, -op.Quantity.to_i)
      end
      self.update_attributes!(IsPreSale: true) if order_is_pre
    end if Company.need_stock?(stock_company_id)
    return status, message
  end

  def cancel opt
    ActiveRecord::Base.transaction(requires_new: true) do
      if Company.need_stock?(self.CompanyID) or self.PID != '00000000-0000-0000-0000-000000000000'
        product_stocks = DepotProductStock.where(DepotID: self.DepotId, ProductID: order_products.map(&:ProductID)).lock
        product_stocks_hash = Hash[product_stocks.map { |ps| [ps.ProductID, ps] }]
        self.order_products.includes(:product).each do |op|
          ProductStockLog.create!(DataID: self.id, ProductCode: op.product.Code, ProductName: op.product.Name, ChangeNumber: op.Quantity.to_i,
                                  Unit: op.product.Unit, ChangeType: 6, IP: opt[:user_ip], Agent: opt[:user_agent], DataDetailID: op.id,
                                  ProductID: op.ProductID, BeforeNumber: product_stocks_hash[op.ProductID].Stock, DepotID: self.DepotId)
          product_stocks_hash[op.ProductID].increment_with_sql!(:Stock, op.Quantity.to_i)
        end
      end
      self.order_coupons.includes(:user_coupon).each do |oc|
        coupon = oc.user_coupon
        coupon.update_attributes!(CurrentCount: coupon.CurrentCount + 1)
        oc.destroy!
      end
      #退单之后返换现金余额，Type的值2表示订单退回；
      if (cash_volume = self.CashVolume).present?
        current_user = self.user
        current_user.increment_with_sql!(:CashVolume, cash_volume)
        current_user.cash_volume_histories.create!(CurrentCash: current_user.CashVolume , DeltaCash: cash_volume, Type: 2, OrderID: self.ID)
      end
    end
    return true
  end

  def check_price
    self.order_products.includes(:product).each do |op|
      return false, "#{op.ProductName} 价格有变化, 请重新下单" if op.Price != 0 and op.Price.round(2) != op.product.ProductPrice.round(2)
    end
    return true
  end

  def check_price_and_stock depot_id=nil
    total_price = self.data.first
    if total_price != self.CostItem.round(2)
      self.update_attributes(OrderStatus: 6)
      return false, "订单商品价格有变化"
    end
    depot_id ||= self.DepotId
    if depot_id.present?
      product_stocks = DepotProductStock.includes(:product).where(DepotID: depot_id, ProductID: order_products.map(&:ProductID))
      return false, "库存不足" if product_stocks.blank?
      product_stocks_hash = Hash[product_stocks.map { |ps| [ps.ProductID, ps] }]
      order_products.each do |op|
        #赠送的商品不判断库存
        if op.Price != 0 and op.Quantity > product_stocks_hash[op.ProductID].Stock
          return false, "#{op.product.Name} 库存不足"
        end
      end
    else
      return false, "库存不足"
    end
    return true
  end

  def giveaway_total
    # self.GiveawayTotal.to_f + self.CouponPrice.to_f + self.PointPrice.to_f + self.AppDiscount.to_f
    self.GiveawayTotal.to_f + self.CouponPrice.to_f + self.CashVolume.to_f + self.AppDiscount.to_f
  end

  # 老数据是“确认订单”  心数据是“确认订单200”
  def logistics_logs
    order_logs.where("Remark in (?) or Remark like '%确认收款%' or Remark like '%确认订单%' or Remark like '%已发出%'", %w(打印四联单 订单发货 确认打印完成))
  end

  def status_show
    case self.OrderStatus
      when -1
        '已取消'
      when 1, 10
        self.CanceledStatus == 2 ? '已取消' : '已提交'
      when 2, 7
        self.CanceledStatus == 2 ? '已取消' : '待出库'
      when 3
        '待收货'
      when 4, 5, 8
        '已完成'
    end
  end

  def status_str
    case self.OrderStatus
      when 1, 10
        '已提交'
      when 2
        '已确认'
      when 7
        '配货中'
      when 3
        '待收货'
      when 4, 5, 8
        '已完成'
    end
  end

  def set_buy_count
    self.order_products.each do |op|
      md5_key = Digest::MD5.hexdigest([self.UserID, Date.today.to_s, op.ProductID].join(':'))
      $redis.set(md5_key, $redis.get(md5_key).to_i + op.Quantity)
      $redis.expire(md5_key, 3600*24)
    end
  end

  def auto_replenish_stock
    ops = self.order_products.joins("left join Products p on p.ID = OrderProducts.ProductID")
              .joins("inner join DepotProductStocks dps on dps.ProductID = p.ID")
              .where("p.Type != 0 and dps.State = 2 and dps.DepotID = ? and dps.Stock < p.StockUnderNumber", self.DepotId)
    ops.each do |op|
      ActiveRecord::Base.connection.execute("call PROC_AutoReplenishStock('#{op.ProductID}', '#{self.DepotId}')")
      ActiveRecord::Base.clear_active_connections!
    end
  end

  def set_product_hash
    @product_hash, @group_hash, @company_hash, @brand_hash = {}, {}, {}, {}
    order_products.includes(:product => [:product_info]).each do |op|
      @group_hash[op.product.ProductGroupsID] = Array.new if !@group_hash[op.product.ProductGroupsID]
      @group_hash[op.product.ProductGroupsID] << op
      @brand_hash[op.product.ProductBrandID] = Array.new if !@brand_hash[op.product.ProductBrandID]
      @brand_hash[op.product.ProductBrandID] << op
      @company_hash[op.product.CompanyID] = Array.new if !@company_hash[op.product.CompanyID]
      @company_hash[op.product.CompanyID] << op
      @product_hash[op.ProductID] = op
    end
  end

  private
  def delete_order_products
    self.order_products.delete_all()
  end

  def set_salesman
    saler = Salesman.find_by(InviteCode: self.InvitationCode)
    self.SalesmanID = saler.ID if saler
  end

  def set_delivery_time
    self.DeliveryTime = self.DeliveryTime.to_i
  end
end

