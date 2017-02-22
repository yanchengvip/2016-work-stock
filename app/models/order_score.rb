class OrderScore < ActiveRecord::Base
  self.table_name = 'order_scores'

  include UUIDHelper

  belongs_to :order,foreign_key: 'OrderID'
  has_many :order_score_tags, foreign_key: 'OrderScoreID'
  validates :OrderID, presence: true

  #after_create :give_coupon

  private
  def give_coupon
    county = County.find_by(ID: self.order.CountyID)
    activities = Activity.related_activities(self.order.CostItem, self.order.CompanyID, county.CityID)
    activities[1].coupons.each do |coupon|
      UserCoupon.create(UsersID: self.order.UserID, Price: coupon.CouponPrice, Status: 1, Source: 4, UseMoney: coupon.ActivityPrice, IsRead: 0,
                    StartDate: Date.today, EndDate: Date.today + coupon.CouponDays.days - 1.second, Cause: '满赠优惠券', CouponID: coupon.ID)
      Notification.create(UserID: self.order.UserID, Content: "您有1张优惠券到账,优惠金额为#{coupon.CouponPrice.round(2)}元", Type: 1, Remark: "通过满赠活动赠送优惠券 优惠券金额为#{coupon.CouponPrice.round(2)}元")
    end if activities[1]
  end
end

