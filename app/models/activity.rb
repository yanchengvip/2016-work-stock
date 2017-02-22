class Activity < ActiveRecord::Base
  self.table_name = 'Activities'

  # Type:
  # 1: 满送优惠券  2: 满减  3: 满折  4: 满赠
  #
  # Status:
  # 0: 保存 -1: 删除 1: 一级审批 2: 二级审批 3: 驳回 4: 已上线 5: 已取消

  has_many :activity_products, :foreign_key => 'ActivityID'
  has_many :activity_coupons, :foreign_key => 'ActivityID'
  has_many :coupons, through: :activity_coupons

  def title
    case self.Type
    when 1
      "订单满#{self.ActivityPrice}元送#{self.GiftCouponPrice}元优惠券"
    when 2
      "订单满#{self.ActivityPrice}元减#{self.SubPrice}元"
    when 3
      "订单满#{self.ActivityPrice}元享#{self.Discount}折"
    when 4
      self.Title
    end
  end

  def self.related_activities money, company_id, city_id
    activities_hash = Hash.new
    activities = Activity.where("? >= ActivityPrice and status = 4 and BeginDate <= ? and EndDate >= ? and CompanyID = ? and (CityID = ? or CityID is null)", money, Time.now, Time.now, company_id, city_id).order("Type, ActivityPrice desc")
    #activities = Activity.where("? >= ActivityPrice and status = 4 and BeginDate <= ? and EndDate >= ? and CompanyID = ?", money, Time.now, Time.now, company_id).order("Type, ActivityPrice desc")
    activities.each do |activity|
      activities_hash[activity.Type] = activity if !activities_hash[activity.Type]
    end
    return activities_hash
  end

  def self.city_activities company_ids, city_id
    # change by lzh
    # activities = Activity.where("status = 4 and BeginDate <= ? and EndDate >= ? and CompanyID in (?) and (CityID = ? or CityID is null)", Time.now, Time.now, company_ids, city_id).order("Type, ActivityPrice")
    activities = Activity.where("status = 4 and BeginDate <= ? and EndDate >= ? and CompanyID in (?) and (CityID = ? or CityID is null)", Time.now, Time.now, company_ids, city_id).order("ActivityPrice,Type")
    # change by lzh
    #activities = Activity.where("status = 4 and BeginDate <= ? and EndDate >= ? and CompanyID in (?)", Time.now, Time.now, company_ids).order("Type, ActivityPrice")
    hash = {}
    activities.each do |activity|
      hash[activity.CompanyID] = Array.new if !hash[activity.CompanyID]
      hash[activity.CompanyID] << activity
    end
    return hash
  end

  # 购物车显示的优惠活动详情
  def self.active_benefit_info money,company_id
    #SELECT ID , Type, max(ActivityPrice)  FROM  StockProduction0325.Activities WHERE ActivityPrice >= 100 GROUP BY Type;
    # Activity.select("ID,Type,Title,ActivityPrice,max(ActivityPrice)").group('Type')
    # Activity.where("(Type= ? or Type = ?  or Type = ?) and ActivityPric e >= ? and BeginDate <= ? and EndDate >= ?",'2','3','4','500',Time.now,Time.now).order('ActivityPrice DESC')

    # a2 = Activity.where("Type=2 and Status= 4 and ActivityPrice >= ? and BeginDate <= ? and EndDate >= ? and CompanyID = ?",money,Time.now,Time.now,company_id).order('ActivityPrice DESC').first
    # a3 = Activity.where("Type=3 and Status= 4 and ActivityPrice >= ? and BeginDate <= ? and EndDate >= ? and CompanyID = ?",money,Time.now,Time.now,company_id).order('ActivityPrice DESC').first
    # a4 = Activity.where("Type=4  and Status= 4 and ActivityPrice >= ? and BeginDate <= ? and EndDate >= ? and CompanyID = ?",money,Time.now,Time.now,company_id).order('ActivityPrice DESC').first
    # ids = []
    # ids.push a2.ID if !a2.nil?
    # ids.push a3.ID if !a3.nil?
    # ids.push a4.ID if !a4.nil?
    # @activity = Activity.includes(:activity_products).where(ID:ids)
    # return @activity

    activities_hash = Hash.new
    activities = Activity.includes(:activity_products).where("Type in (?) and Status= 4 and ActivityPrice >= ? and BeginDate <= ? and EndDate >= ? and CompanyID = ?",[2,3,4],money,Time.now,Time.now,company_id).order('Type,ActivityPrice DESC')
    activities.each do |activity|
      activities_hash[activity.Type] = activity if !activities_hash[activity.Type]
    end
    return activities_hash.values
  end

end
