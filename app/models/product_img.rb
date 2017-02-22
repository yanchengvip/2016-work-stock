# == Schema Information
#
# Table name: ProductImgs
#
#  ID            :string(36)       default(""), not null, primary key
#  Name          :string(255)
#  Src           :string(255)
#  Href          :string(255)
#  Describe      :text(4294967295)
#  OrderBy       :integer
#  ProductID     :string(36)
#  LSrc          :string(255)
#  PhotoID       :string(36)
#  CreateTime    :datetime
#  CreateBy      :string(100)
#  UpdateTime    :datetime
#  UpdateBy      :string(100)
#  FileQiniuName :string(255)
#

class ProductImg < ActiveRecord::Base
  self.table_name = 'ProductImgs'

  belongs_to :product, :foreign_key => "ProductID"

  def url version=nil
    if self.FileQiniuName.present?
      img_url = Settings.qiniu_base_url + self.FileQiniuName
      return img_url + "-" + version if version.in?(%w(v100 v150 v220 v400))
      return img_url
    end
    return Settings.img_base_url + self.Src.to_s
  end

end
