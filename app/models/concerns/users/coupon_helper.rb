module Users
  module CouponHelper
    extend ActiveSupport::Concern

    included do
      has_many :coupons, :class_name => "UserCoupon", :foreign_key => "UsersID"
      has_many :pay_coupon_logs, ->{where(PayStatus: 1)}, :foreign_key => "UserId"

      # after_create :give_gift_bag
    end

    def unused_coupons(page=1)
      self.coupons.where("status = 1 and EndDate >= ?", Time.now).update_all(IsRead: true)
      self.coupons.select("usercoupons.*, case c.CouponType when 5 then 1 else 0 end as big_type")
                  .includes(:coupon => [:company => [:company_cities]])
                  .joins("left join coupons c on c.ID = usercoupons.CouponID")
                  .where("usercoupons.status = 1 and EndDate >= ? and (CouponID is null or CouponStatus = 1)", Time.now)
                  .order("big_type desc, CouponDiscount, Price desc, EndDate")
                  .page(page).per(20)
    end

    def dated_coupons(page=1)
      self.coupons.select("usercoupons.*, case c.CouponType when 5 then 1 else 0 end as big_type")
                  .includes(:coupon => [:company => [:company_cities]])
                  .joins("left join coupons c on c.ID = usercoupons.CouponID")
                  .where("usercoupons.status = 1 and (EndDate < ? or CouponStatus = 0)", Time.now)
                  .order("EndDate desc, big_type desc, CouponDiscount, Price desc")
                  .page(page).per(20)
    end

    def used_coupons(page=1)
      self.coupons.includes(:coupon => [:company => [:company_cities]])
                  .joins("right join order_coupons oc on oc.UserCouponID = usercoupons.ID").order("oc.CreateTime desc")
                  .page(page).per(20)
    end

    def unused_coupons_with(company_id)
      self.coupons.includes(:coupon => [:company => [:company_cities]])
                  .joins("left join coupons c on c.ID = usercoupons.CouponID")
                  .where("usercoupons.status = 1 and EndDate >= ? and (CouponID is null or CouponStatus = 1) and (CouponID is null or c.CompanyID is null or c.CompanyID = ?)", Time.now, company_id)
    end

    def unread_coupons(city_id)
      company_ids = CompanyCity.where(CityID: city_id).map(&:CompanyID)
      self.coupons.includes(:coupon => [:company => [:company_cities]])
          .joins("left join coupons c on c.ID = usercoupons.CouponID")
          .where("usercoupons.status = 1 and IsRead = 0 and (c.CompanyID is null or c.CompanyID in (?)) and usercoupons.EndDate >= ?", company_ids, Time.now)
    end

    def usable_coupons(order_money)
      self.unused_coupons.where("(UseMoney is null or UseMoney <= ?) and (StartDate is null or StartDate <= ?)", order_money, Time.now())
    end

    def collect_coupon coupon
      ActiveRecord::Base.transaction do
        coupon.lock!
        return false, '你已经领取过该优惠券' if UserCoupon.find_by(UsersID: self.id, CouponID: coupon.ID)
        return false, '该优惠券领取时间还未开始' if coupon.BeginTime > Time.now
        return false, '该优惠券领取时间已截止' if coupon.EndTime < Time.now
        return false, '慢了一步，该优惠券已抢光了' if coupon.CouponCount <= coupon.CurrentCount
        coupon.increment_with_sql!(:CurrentCount)
        return self.coupons.create(Price: coupon.CouponPrice, Status: 1, Source: 1, UseMoney: coupon.ActivityPrice, StartDate: Date.today, EndDate: Date.today + coupon.CouponDays.days - 1.second, Cause: '领券中心', CouponID: coupon.ID)
      end
    end

    def coupons_by(order)
      return [], [] if order.UserID != self.ID
      order.set_product_hash
      order_usable_coupons = Array.new
      order_unusable_coupons = Array.new
      unused_coupons_with(order.CompanyID).each do |coupon|
        can_use, message = coupon.can_use_in?(order)
        if can_use
          order_usable_coupons << coupon
          coupon.set_discount_money(order)
        else
          order_unusable_coupons << coupon
        end
      end
      order_usable_coupons.sort_by!{|coupon| -coupon.discount_money}
      return order_usable_coupons, order_unusable_coupons
    end

    # def give_gift_bag
    #
    #   # change by lzh,添加  Type:  0 表示是注册礼包
    #   # gift_bag = GiftBag.find_by(CompanyID: self.CompanyID, State: 1, Status: 2,Type: 0)
    #   gift_bag = GiftBag.find_by(CompanyID: self.CompanyID, State: 1, Status: 2,Type: 0)
    #   # change by lzh
    #
    #   # gift_bag = GiftBag.find_by(CompanyID: self.CompanyID, State: 1, Status: 2)
    #   gift_bag.coupons.each do |coupon|
    #     count = coupon.CouponCount.to_i > 0 ? coupon.CouponCount : 1
    #     self.coupons.create(Price: coupon.CouponPrice, CouponDiscount: coupon.CouponDiscount, UseMoney: coupon.ActivityPrice, Status: 1,
    #                         StartDate: Date.today, EndDate: Date.today + coupon.CouponDays - 1.second, Source: 0, Cause: '注册礼包',
    #                         ProvideCount: count, CurrentCount: count, CouponID: coupon.ID)
    #   end if gift_bag
    # end
  end
end
