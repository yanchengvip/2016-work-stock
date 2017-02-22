# == Schema Information
#
# Table name: AdvertisePics
#
#  ID                  :string(36)       default(""), not null, primary key
#  AdvertID            :integer          not null
#  Name                :string(255)
#  Src                 :string(255)
#  Href                :string(255)
#  Describe            :string(255)
#  OrderBy             :integer
#  ImgG                :integer
#  AdvertisePicGroupID :string(36)
#  PhotoID             :string(36)
#  CreateTime          :datetime
#  CreateBy            :string(100)
#  UpdateTime          :datetime
#  UpdateBy            :string(100)
#  FileQiniuName       :string(255)
#

class AdvertisePic < ActiveRecord::Base
  self.table_name = 'AdvertisePics'

  def url
    return Settings.qiniu_base_url + self.FileQiniuName if self.FileQiniuName.present?
    return Settings.img_base_url + self.Src.to_s
  end

  def recommend_href
    return "/activity/#{self.ProductRecommendInfoesID}" if self.ProductRecommendInfoesID.present?
    return nil
  end

end
