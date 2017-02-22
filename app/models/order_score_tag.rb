class OrderScoreTag < ActiveRecord::Base
  self.table_name = 'order_score_tags'
  belongs_to :order_score, foreign_key: 'OrderScoreID'
  include UUIDHelper

end