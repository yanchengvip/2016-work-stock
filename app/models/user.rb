# == Schema Information
#
# Table name: Users
#
#  ID            :string(36)       default(""), not null, primary key
#  Name          :string(255)
#  Phone         :string(255)
#  Mail          :string(255)
#  Age           :integer
#  Sex           :boolean
#  Province      :string(255)
#  City          :string(255)
#  Area          :string(255)
#  Address       :string(255)
#  Password      :string(255)
#  BirthMonth    :integer
#  BirthDay      :integer
#  BirthYear     :integer
#  Type          :integer          not null
#  State         :integer          not null
#  Integral      :integer
#  PhotoID       :string(36)
#  CreateTime    :datetime
#  CreateBy      :string(100)
#  UpdateTime    :datetime
#  UpdateBy      :string(100)
#  IsImportUser  :boolean
#  SalesmanID    :string(36)
#  RememberToken :string(255)
#

class User < ActiveRecord::Base
  self.table_name = 'Users'
  include UUIDHelper
  include Redis::Objects
  include Users::CartHelper
  include Users::OrderHelper
  include Users::CouponHelper

  has_many :addresses, ->{where(IsDeleted: false)}, :class_name => "UserAddress", :foreign_key => "UserID"
  has_many :enshrines, ->{order("CreateTime desc")}, :foreign_key => "UserID"

  has_many :invitations, ->{order("CreateTime desc")}, :foreign_key => "UserID"

  has_many :point_histories, ->{order("CreateTime desc")}, :foreign_key => "UserID"
  has_many :point_orders, ->{order("CreateTime desc")}, :foreign_key => "UserID"

  has_one  :user_level, ->{where("Year = ? and Month = ?", Date.today.year, Date.today.month - 1)}, :foreign_key => "UserID"

  has_many :notifications, ->{order("CreateTime desc")}, :foreign_key => "UserID"
  has_many :unread_notifications, ->{where(IsRead: false).order("CreateTime desc")}, :foreign_key => "UserID", :class_name => "Notification"

  has_many :cash_volume_histories, ->{order("CreateTime desc")}, :foreign_key => "UserID"

  has_many :keyword_search_histories, ->{order("CreateTime desc")}, :foreign_key => "UserID"

  before_save :validate_password_confirm
  before_save :set_password_encrypt, if: Proc.new{|user| user.Password_changed?}
  before_create :set_salesman
  after_create :create_coupon

  # change by lzh
  before_update :set_salesman
  # change by lzh

  validate  :valid_check_code, on: :create
  validates :Phone, presence: true, uniqueness: true

  hash_key :cart_hash

  attr_accessor :password_confirmation
  attr_accessor :check_code
  attr_accessor :address

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def authenticate(unencrypted_password)
    (Digest::MD5.hexdigest(unencrypted_password).upcase == self.Password) && self
  end

  def favorites
    self.enshrines.includes(:product)
  end

  def level_name
    level = user_level.try(:UserLevel).to_i
    case level
    when 0
      "新人用户"
    when 1
      "优质买家"
    when 2
      "进货达人"
    when 3
      "黄金店主"
    when 4
      "王牌老板"
    end
  end

  def verified_addresses
    # addresses.joins("left join storeinformations si on si.UserAddressID = useraddresses.ID").where("si.Status = 2")
    addresses.joins("left join storeinformations si on si.UserAddressID = useraddresses.ID").where("si.Status = 2 or si.Status = 1 or si.Status = 0 ")
  end

  def add_to_favorites product_ids
    enshrine = nil
    Product.where(ID: product_ids).each do |product|
      enshrine = Enshrine.find_or_create_by(UserID: self.id, ProductID: product.ID)
    end
    return enshrine.present?
  end

  def today_buys
    ops = OrderProduct.find_by_sql("
      select op.ProductID, sum(op.Quantity) Quantity
      from OrderProducts op
      left join Orders o on o.ID = op.OrderID
      where o.UserID = '#{self.id}' and o.OrderStatus not in (-1, 0, 6, 11) and op.CreateTime > '#{Date.today.to_s}'
      group by op.ProductID
    ")
    return Hash[ops.map{|op| [op.ProductID, op.Quantity]}]
  end

  def default_address
    self.addresses.where(IsDefault: 1).first
  end

  def set_default_address address
    return flase, '没有权限' if address.UserID != self.ID
    flag = false
    ActiveRecord::Base.transaction do
      UserAddress.where(UserID: self.ID).update_all(IsDefault: false)
      address.reload.update_attributes!(IsDefault: true)
      flag = true
    end
    return flag
  end

  def increment_with_sql!(attribute, by = 1)
    raise ArgumentError("Invalid attribute: #{attribute}") unless attribute_names.include?(attribute.to_s)
    original_value_sql = "CASE WHEN #{attribute} IS NULL THEN 0 ELSE #{attribute} END"
    by = by.to_i if attribute != :CashVolume
    self.class.where(id: self.id).update_all("#{attribute} = #{original_value_sql} + #{by}")
    reload
  end

  def success_invite tel
    ActiveRecord::Base.transaction do
      self.coupons.create(Price: 25, Status: 1, EndDate: Date.today + 30.days - 1.second, Source: 0)
      self.invitations.create(Phone: tel, CouponPrice: 25, TypeID: 0, Remark: '分享成功')
    end
  end

  def rush_product(product)
    return false, '该商品不是秒杀商品' if product.Type != 2
    return false, '该商品秒杀时间还未开始' if Time.now < product.ActivityBeginTime
    # return false, '该商品秒杀时间已经结束' if Time.now > product.ActivityEndTime
    # return false, '你已经抢购过该商品，不可重复抢购' if ProductActivityUser.where("UserID = ? and ProductID = ? and CreateTime >= ? and CreateTime <= ?", self.ID, product.ID, product.ActivityBeginTime, product.ActivityEndTime).first
    return false, '你已经抢购过该商品，不可重复抢购' if ProductActivityUser.where("UserID = ? and ProductID = ? and CreateTime >= ?", self.ID, product.ID, product.ActivityBeginTime).first
    flag = false
    ActiveRecord::Base.transaction do
      product.lock!
      return false, '秒杀资格已被抢完' if product.CurrentActivityAmount.to_i >= product.MaxActivityAmount.to_i
      Cart.create!(UserID: self.id, ProductID: product.ID, Number: 1, CompanyID: product.CompanyID) if !Cart.find_by(UserID: self.id, ProductID: product.ID)
      ProductActivityUser.create!(UserID: self.id, ProductID: product.ID)
      product.increment_with_sql!(:CurrentActivityAmount)
      flag = true
    end
    return flag
  end

  # Type=0兑换现金,Type=1兑换商品
  # Status使用状态（0=>已使用 | 1=>未使用 | 2=>待审核）
  def exchange_coupon coupon_code
    return false, '兑换码不能为空' if coupon_code.blank?
    coupon = UserCoupon.where('CouponCode = ? and Status in (0,1,2)  and EndDate >= ?', coupon_code, Time.now).first
    return false, '兑换码无效' if !coupon
    return false, '兑换码已被使用' if coupon.Status == 0
    return false, '兑换码已被领取' if coupon.Status == 1 && coupon.UsersID.present?
    return false, '兑换码待审核' if coupon.Status == 2
    # Type=0兑换现金,Type=1兑换商品
    case coupon.Type
    when 0
      return true if coupon.update_attributes(UsersID: self.id)#领取

    when 1
      product = Product.find_by(ID: coupon.ProductID)
      return false, "该商品不存在" if !product
      cart_arr = {UserID:self.id,CompanyID:product.CompanyID,ProductID:coupon.ProductID}
      ActiveRecord::Base.transaction do
        cart = Cart.find_by(cart_arr)
        if cart
           cart.update_attributes!(Number: cart.Number + 1)
           coupon.update_attributes!(UsersID: self.id,Status:0)
           return true
        else
          self.carts.create!(cart_arr.merge({Number:1}))
          coupon.update_attributes!(UsersID: self.id,Status:0)
          return true
        end
      end

    else
      return false, '无此类型的优惠券'
    end
  end

  def exchange_point_product point_product, opt={}
    status, point_order = false, nil
    ActiveRecord::Base.transaction do
      point_product.lock!
      self.lock!
      number = opt[:Number].to_i
      need_point = point_product.Point.to_i * number
      return false, '数据有误' if need_point < 0
      return false, '该商品数量不足' if point_product.TotalNumber < number
      return false, '您的积分不足' if self.Integral.to_i < need_point
      point_product.increment_with_sql!(:TotalNumber, -number)
      self.increment_with_sql!(:Integral, -need_point)
      point_order = PointOrder.create(opt.merge({UserID: self.ID, PointProductID: point_product.ID, Point: point_product.Point, Status: 1}))
      number.times do
        self.coupons.create(Price: point_product.CouponPrice, Status: 1, Source: 0, UseMoney: point_product.CouponUsePrice, StartDate: Date.today, EndDate: Date.today + point_product.Days.days - 1.second, Cause: '积分兑换') if point_product.Type == 0
      end
      PointHistory.create(UserID: self.ID, CurrentPoint: self.Integral, DeltaPoint: -need_point, Type: 2)
      status = true
    end
    return point_order if status
    return status
  end


  private
  def validate_password_confirm
    if !self.Password.nil? and !self.password_confirmation.nil? and self.Password != self.password_confirmation
      errors.add(:base, I18n.t("common.password_inconformity"))
    end
  end

  def set_password_encrypt
    self.Password = Digest::MD5.hexdigest(self.Password).upcase
  end

  def valid_check_code
    if self.Phone_changed?
      errors.add(:base, I18n.t("common.check_code_error")) if !Sms.valid?(self.Phone, self.check_code)
    end
  end

  def create_coupon
    Invitation.where(Phone: self.Phone).each do |invitation|
      self.coupons.create(Price: invitation.CouponPrice, UseMoney: invitation.UseMoney, Status: 1, EndDate: Date.today + 30.days - 1.second, Source: 0)
    end
  end

  def set_salesman
    if self.SalesmanInviteCode and (salesman = Salesman.find_by(InviteCode: self.SalesmanInviteCode, OnTheJob: false))
      self.SalesmanID = salesman.ID
    end
  end
end
