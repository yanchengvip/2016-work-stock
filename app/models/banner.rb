class Banner < ActiveRecord::Base
  self.table_name = "Banners"

  def pic_url
    return Settings.qiniu_base_url + self.PicQiNiu if self.PicQiNiu.present?
    return ""
  end
end
