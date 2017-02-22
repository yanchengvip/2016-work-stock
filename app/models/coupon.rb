# usage 0直接赠券 1领券中心 2优惠券礼包 3周年庆转盘 4周年庆砸蛋 5周年庆大放送

class Coupon < ActiveRecord::Base
  has_many :coupon_products, :foreign_key => "CouponID"
  has_many :products, through: :coupon_products, source: :product
  has_many :coupon_productgroups, :foreign_key => "CouponID"
  has_many :product_groups, through: :coupon_productgroups, source: :product_group
  has_many :coupon_productbrands, :foreign_key => "CouponID"
  has_many :product_brands, through: :coupon_productbrands, source: :product_brand

  belongs_to :company, :foreign_key => "CompanyID"

  scope :birth_wheel, ->(company_id){where("Status = 2 and CouponStatus = 1 and coupons.Usage = 3 and CompanyID = ? and BeginTime <= ? and EndTime > ?", company_id, Time.now, Time.now).order("CouponPrice")}
  scope :birth_egg, ->(company_id){where("Status = 2 and CouponStatus = 1 and coupons.Usage = 4 and CompanyID = ? and BeginTime <= ? and EndTime > ?", company_id, Time.now, Time.now).order("CouponPrice")}
  scope :birth_gift, ->(company_id){where("Status = 2 and CouponStatus = 1 and coupons.Usage = 5 and CompanyID = ? and BeginTime <= ? and EndTime > ?", company_id, Time.now, Time.now).order("CouponPrice")}

  def LogoUrl version=nil
    if self.LogoQiNiu.present?
      url = Settings.qiniu_base_url + self.LogoQiNiu
      return url + "-" + version if version.in?(%w(v100 v150 v220 v400))
      return url
    end
    return ''
  end

  def CouponPrice
    return self[:CouponPrice].to_i if self[:CouponPrice] == self[:CouponPrice].to_i
    return self[:CouponPrice]
  end

  def use_url
    if self.ProductRecommendInfoID.present?
      return "/activity/#{self.ProductRecommendInfoID}"
    elsif self.CouponType.in?([0, 5])
      return "/products/list"
    elsif self.CouponType == 1
      return "/coupons/#{self.ID}/products" if self.company.ThirdType == 3
      return "/products/list?company_id=#{self.CompanyID}"
    else
      return "/coupons/#{self.ID}/products"
    end
  end

  def type_name
    if self.CouponType == 0
      return "通用券"
    elsif self.CouponType == 1
      return "通用券"
    elsif self.CouponType == 2
      return "品类券"
    elsif self.CouponType == 3
      return "品牌券"
    elsif self.CouponType == 4
      return "单品券"
    elsif self.CouponType == 5
      return "基本券"
    elsif self.CouponType == 6
      return "代金券"
    end
  end

  def self.can_collect(user, city_id)
    company_ids = CompanyCity.where(CityID: city_id).map(&:CompanyID)
    Coupon.select("Coupons.*, if(uc.UsersID is null, 0, 1) has_collect").includes(:company)
          .joins("left join UserCoupons uc on uc.CouponID = Coupons.ID and uc.UsersID = '#{user.try(:ID)}'")
          .where("coupons.Usage = 1 and coupons.Status = 2 and coupons.CurrentCount < CouponCount and BeginTime < ? and EndTime > ? and (CouponType = 0 or CompanyID in (?)) and (uc.ID is null or uc.Status = 1)", Time.now, Time.now, company_ids)
          .order("CouponPrice desc, EndTime asc, BeginTime asc")
  end

  def self.can_collect_universal(user, company_id)
    Coupon.select("Coupons.*, if(uc.UsersID is null, 0, 1) has_collect").includes(:company)
          .joins("left join UserCoupons uc on uc.CouponID = Coupons.ID and uc.UsersID = '#{user.try(:ID)}'")
          .where("coupons.Usage = 1 and coupons.Status = 2 and coupons.CurrentCount < CouponCount and BeginTime < ? and EndTime > ? and (CouponType = 0 or (CouponType = 1 and CompanyID = ?)) and (uc.ID is null or uc.Status = 1)", Time.now, Time.now, company_id)
          .order("CouponPrice desc, EndTime asc, BeginTime asc")
  end

  def self.can_collect_by_type(user, city_id)
    coupons = Hash.new
    Coupon.can_collect(user, city_id).each do |coupon|
      coupon_type = coupon.CouponType == 0 ? 1 : coupon.CouponType
      coupons[coupon_type] = Array.new if !coupons[coupon_type]
      coupons[coupon_type] << coupon
    end
    return coupons
  end

  def self.buy_coupon
    Coupon.find_by(ID: Settings.buy_coupon)
  end

  def increment_with_sql!(attribute, by = 1)
    raise ArgumentError("Invalid attribute: #{attribute}") unless attribute_names.include?(attribute.to_s)
    original_value_sql = "CASE WHEN #{attribute} IS NULL THEN 0 ELSE #{attribute} END"
    self.class.where(id: self.id).update_all("#{attribute} = #{original_value_sql} + #{by.to_i}")
    reload
  end

end
