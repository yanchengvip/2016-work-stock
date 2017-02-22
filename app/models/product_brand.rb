class ProductBrand < ActiveRecord::Base
  self.table_name = 'ProductBrands'

  def cover_url version=nil
    if self.LogoQiNiu.present?
      url = Settings.qiniu_base_url + self.LogoQiNiu
      return url + "-" + version if version.in?(%w(v100 v150 v220 v400))
      return url
    end
    return ''
  end
end
