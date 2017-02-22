class PointProduct < ActiveRecord::Base
  self.table_name = 'PointProducts'

  def cover_url version=nil
    if self.CoverQiniu.present?
      url = Settings.qiniu_base_url + self.CoverQiniu
      return url + "-" + version if version.in?(%w(v100 v150 v220 v400))
      return url
    end
    return ''
  end

  def increment_with_sql!(attribute, by = 1)
    raise ArgumentError("Invalid attribute: #{attribute}") unless attribute_names.include?(attribute.to_s)
    original_value_sql = "CASE WHEN #{attribute} IS NULL THEN 0 ELSE #{attribute} END"
    self.class.where(id: self.id).update_all("#{attribute} = #{original_value_sql} + #{by.to_i}")
    reload
  end

end
