class StoreInformation < ActiveRecord::Base
  self.table_name = 'storeinformations'
  include UUIDHelper

  before_save :change_status

  private
  def change_status
    self.Status = 1 if self.changed?
  end
end
