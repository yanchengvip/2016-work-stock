class ActivityProduct < ActiveRecord::Base
  self.table_name = 'ActivityProducts'

  belongs_to :activity, :foreign_key => 'ActivityID'
end
