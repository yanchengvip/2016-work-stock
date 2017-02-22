class ProductInfo < ActiveRecord::Base
  self.table_name = 'ProductInfoes'
  has_many  :product_imgs, ->{order("OrderBy")}, :foreign_key => "ProductInfoID"
  belongs_to :group, :class_name => "ProductGroup", :foreign_key => "ProductGroupsID"

  def cover_url version=nil
    if self.CoverQiniu.present?
      url = Settings.qiniu_base_url + self.CoverQiniu
      return url + "-" + version if version.in?(%w(v100 v150 v220 v400))
      return url
    end
    return ''
  end
end
