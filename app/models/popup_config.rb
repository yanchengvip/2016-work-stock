class PopupConfig < ActiveRecord::Base
  belongs_to :coupon, foreign_key: "CouponID"
  belongs_to :city, foreign_key: "CityID"

  def picture_url
    return Settings.qiniu_base_url + self.PictureQiNiu if self.PictureQiNiu.present?
    return ''
  end

  def self.enabled(city_id, type)
    PopupConfig.includes(:city).where("IsEnable = 1 and CityID = ? and popup_configs.Condition in (?) and BeginTime < ? and EndTime > ?", city_id, type, Time.now, Time.now).order("Priority")
  end
end
