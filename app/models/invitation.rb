class Invitation < ActiveRecord::Base
  self.table_name = 'Invitations'
  include UUIDHelper

  # TypeID
  #   1: 新年优惠券抽奖(5元、10元、20元、50元随机)
  #   2: 38妇女节送3元优惠券
  belongs_to :user
end
