module UUIDHelper
  def self.included(base)
    base.before_create :assign_uuid
  end

  private
  def assign_uuid
    self.ID = UUIDTools::UUID.timestamp_create().to_s if self.ID.blank?
  end
end
