class ProductRecommendInfo < ActiveRecord::Base
  self.table_name = 'ProductRecommendInfoes'

  has_many :product_recommend_info_details, :foreign_key => 'ProductRecommendInfoID'
  has_many :products, :through => :product_recommend_info_details, :source => :product
  has_many :banners, ->{where("StartDate <= ? and EndDate > ?", Time.now, Time.now)}, :foreign_key => 'ProductrecommendinfoID'
  has_many :coupons, ->{where("coupons.Status = 2 and CouponCount > coupons.CurrentCount and BeginTime <= ? and EndTime > ?", Time.now, Time.now).order("CouponPrice desc, EndTime, BeginTime")}, :foreign_key => 'ProductRecommendInfoID'

  #change by lzh
  has_many :activity_floors,:foreign_key => 'ParentProductRecommendID'


  def info_pic
    return Settings.qiniu_base_url + self.Link if self.Link.present?
    return ""
  end

  def self.pc_recommends(company_id)
    ProductRecommendInfo.where("(CreateTime < '2016-06-15' or CreateTime is null) and ProductRecommendType = 1 and CompanyID = ?", company_id).order("OrderBy")
  end




end
