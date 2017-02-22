class ActivityFloor < ActiveRecord::Base

  has_many :activity_floor_products, ->{order(Sort: :asc)}, :foreign_key => 'ActivityFloorID'
  # has_many :activity_floor_products, ->{order("activity_floor_products.Sort ASC")}, :foreign_key => 'ActivityFloorID'
  has_many :products, ->{where("Products.State = 2 and (ActivityBeginTime is null or (ActivityBeginTime <= ? and ActivityEndTime > ?))", Time.now, Time.now)}, through: :activity_floor_products, :source => :product

  #product_recommend_info就是活动,模型关联关系并非加在activity模型
  belongs_to :product_recommend_info,:foreign_key => 'ParentProductRecommendID'
  # belongs_to :product_recommend_info,:foreign_key => 'ProductRecommendInfoID'

  def cover_url version=nil
    if self.PictureQiNiu.present?
      url = Settings.qiniu_base_url + self.PictureQiNiu
      return url + "-" + version if version.in?(%w(v100 v150 v220 v400))
      return url
    end
    return ''
  end


end
