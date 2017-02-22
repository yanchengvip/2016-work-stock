# == Schema Information
#
# Table name: UserAddresses
#
#  ID              :string(36)       default(""), not null, primary key
#  UserID          :string(36)       default(""), not null
#  Province        :string(255)
#  City            :string(255)
#  County          :string(255)
#  Detailedaddress :string(255)
#  ZipCode         :string(255)
#  ShipName        :string(255)
#  Telephone       :string(255)
#  Mobile          :string(255)
#  IsDefault       :boolean
#  CreateTime      :datetime
#  CreateBy        :string(100)
#  UpdateTime      :datetime
#  UpdateBy        :string(100)
#  CountyID        :string(36)
#

class UserAddress < ActiveRecord::Base
  self.table_name = 'UserAddresses'
  include UUIDHelper

  belongs_to :user, :foreign_key => "UserID"
  belongs_to :county, :foreign_key => "CountyID"
  has_one :store_information, :foreign_key => "UserAddressID"

  validates  :Province, length: { minimum: 1 }
  validates  :City, length: { minimum: 1 }
  validates  :County, length: { minimum: 1 }
  validates  :Detailedaddress, length: { minimum: 1 }
  validates  :ShipName, length: { minimum: 1 }
  # validates  :Mobile, length: { is: 11 }

  before_save :set_area

  # change by lzh
  after_create :give_gift_bag

  # change by lzh
  def give_gift_bag

    city = City.joins("left join Provinces p on p.ID = Cities.ProvinceID").where("Cities.CityName = ? and p.ProvinceName = ?", self.City, self.Province ).first
    self.user.update_attribute(:CompanyID, city.CompanyID)

    # change by lzh,添加  Type:  0 表示是注册礼包
    gift_bag = GiftBag.find_by(CompanyID: self.user.CompanyID, State: 1, Status: 2,Type: 0)
    # change by lzh

    # gift_bag = GiftBag.find_by(CompanyID: self.CompanyID, State: 1, Status: 2)
    gift_bag.coupons.each do |coupon|
      count = coupon.CouponCount.to_i > 0 ? coupon.CouponCount : 1
      UserCoupon.create(UsersID: self.user.ID,Price: coupon.CouponPrice, CouponDiscount: coupon.CouponDiscount, UseMoney: coupon.ActivityPrice, Status: 1,
                        StartDate: Date.today, EndDate: Date.today + coupon.CouponDays - 1.second, Source: 0, Cause: '注册礼包',
                        ProvideCount: count, CurrentCount: count, CouponID: coupon.ID)
    end if gift_bag
  end
  # change by lzh

  private
  def set_area
    county = County.joins("left join Cities c on c.ID = Counties.CityID left join Provinces p on p.ID = c.ProvinceID")
                   .where("Counties.CountyName = ? and c.CityName = ? and p.ProvinceName = ?", self.County, self.City, self.Province)
                   .first
    if county
      self.CountyID = county.ID
      self.CompanyID = county.city.CompanyID
      depot_send_county = DepotSendCounty.find_by(CountyID: county.ID)
      self.DepotID = depot_send_county.DepotID if depot_send_county.present?
    end
  end

end
