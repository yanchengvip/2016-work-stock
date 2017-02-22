class OpenScreen < ActiveRecord::Base

  def cover_url version=nil
    if self.pictureQiNiu.present?
      url = "http:" + Settings.qiniu_base_url + self.pictureQiNiu
      return url + "-" + version if version.in?(%w(v100 v150 v220 v400))
      return url
    end
    return ''
  end


end
