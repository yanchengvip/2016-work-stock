class HFloor < ActiveRecord::Base
  self.table_name = 'hfloors'

  has_many :floor_items, ->{where("IsEnabled = true").order("Sort")}, foreign_key: "HFloorID", class_name: "HFloorItem" # mobile
  has_one  :floor_item, ->{where("IsEnabled = true")}, foreign_key: "HFloorID", class_name: "HFloorItem"  # pc

  def cover_url version=nil
    if self.NavIconQiNiu.present?
      url = Settings.qiniu_base_url + self.NavIconQiNiu
      return url + "-" + version if version.in?(%w(v100 v150 v220 v400))
      return url
    end
    return ''
  end

end
