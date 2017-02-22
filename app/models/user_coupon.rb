
=begin
 == Schema Information

Table name: UserCoupons

Columns:
 ID	char(36) PK
UsersID	char(36)
EndDate	datetime
Price	decimal(18,2)
Status	tinyint(3) UN
Source	tinyint(3) UN
CreateTime	datetime
CreateBy	varchar(100)
UpdateTime	datetime
UpdateBy	varchar(100)
Cause	varchar(255)
StartDate	datetime
UseMoney	int(11)
CouponAppliesID	char(36)
CouponCode	varchar(30)
CouponApply_ID	char(36)
Users_ID	char(36)
Type	int(1)
ProductID	char(36)
=end
#
# Status：  0=已使用，1=未使用，2=待审核
# Type:     0=现金券，1=兑换卷(赠品)
# Source:   0=系统活动, 1=领券中心, 2=赠券中心
#
class UserCoupon < ActiveRecord::Base
  self.table_name = 'UserCoupons'
  include UUIDHelper

  belongs_to :user, :foreign_key => "UsersID"
  belongs_to :coupon, :foreign_key => "CouponID"
  belongs_to :product,foreign_key: 'ProductID'
  before_save :set_status, if: Proc.new{|uc| uc.CurrentCount_changed?}

  attr_accessor :discount_money

  def Price
    return self[:Price].to_i if self[:Price] == self[:Price].to_i
    return self[:Price].to_f
  end

  def title
    return coupon.Title if coupon.present?
    return "全场通用券"
  end

  def sub_title
    return coupon.SubTitle if coupon.present?
    return self.UseMoney.to_f > 0 ? "订单满#{self.UseMoney}元可用": "下单即可使用"
  end

  def type_name
    if coupon.blank? or coupon.CouponType == 0
      return "通用券"
    elsif coupon.CouponType == 1
      return "通用券"
    elsif coupon.CouponType == 2
      return "品类券"
    elsif coupon.CouponType == 3
      return "品牌券"
    elsif coupon.CouponType == 4
      return "单品券"
    elsif coupon.CouponType == 5
      return "基本券"
    elsif coupon.CouponType == 6
      return "代金券"
    end
  end

  def use_url
    return coupon.use_url if coupon.present?
    return "/products/list"
  end

  def attrs_json
    Jbuilder.encode do |json|
      json.(self, :ID, :Title, :SubTitle, :Price)
      json.TypeName self.type_name
      json.StartDate (self.StartDate || Date.today).strftime("%Y.%m.%d")
      json.EndDate self.EndDate.strftime("%Y.%m.%d")
    end
  end

  def attrs_hash
    {
      "ID" => self.ID,
      "Title" => self.Title,
      "SubTitle" => self.SubTitle,
      "Price" => self.Price,
      "TypeName" => self.type_name,
      "StartDate" => (self.StartDate || Date.today).strftime("%Y.%m.%d"),
      "EndDate" => self.EndDate.strftime("%Y.%m.%d")
    }
  end

  def can_use_in? order
    return false, "优惠券无效" if self.UsersID != order.UserID
    return false, "优惠券已被使用" if self.Status != 1
    return false, "优惠券已失效" if self.EndDate < Time.now or (self.coupon and self.coupon.CouponStatus == 0)
    return false, "优惠券还未到使用时间" if self.StartDate.present? and self.StartDate > Time.now
    order.set_product_hash if !order.product_hash or !order.group_hash or !order.company_hash or !order.brand_hash
    if coupon.blank? or coupon.CouponType.in?([0, 5, 6])
      return true if order.CostItem >= self.UseMoney.to_f
    elsif coupon.CouponType == 1
      total = order.company_hash[order.CompanyID].to_a.inject(0){|sum, op| sum + op.Price * op.Quantity}
      return true if total >= self.UseMoney.to_f
    elsif coupon.CouponType == 2
      total = 0
      coupon.product_groups.each do |group|
        t = order.group_hash[group.ID].to_a.inject(0){|sum, op| sum + op.Price * op.Quantity}
        total += t
      end
      return true if total >= self.UseMoney.to_f
    elsif coupon.CouponType == 3
      total = 0
      coupon.product_brands.each do |brand|
        t = order.brand_hash[brand.ID].to_a.inject(0){|sum, op| sum + op.Price * op.Quantity}
        total += t
      end
      return true if total >= self.UseMoney.to_f
    elsif coupon.CouponType == 4
      total = 0
      coupon.products.each do |p|
        if (op = order.product_hash[p.ID])
          total += op.Price * op.Quantity
        end
      end
      return true if total >= self.UseMoney.to_f
    end
    return false, "订单金额不满足优惠券使用金额"
  end

  def set_discount_money(order)
    if coupon and coupon.CouponType == 5
      dm = (order.CostItem * (1 - coupon.CouponDiscount)).round(2)
      self.discount_money = dm < coupon.MaxPrice ? dm : coupon.MaxPrice
    else
      self.discount_money = self.Price
    end
  end

  private
  def set_status
    if self.CurrentCount <= 0
      self.Status = 0
    else
      self.Status = 1
    end
  end
end
