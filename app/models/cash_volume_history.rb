class CashVolumeHistory < ActiveRecord::Base
  include UUIDHelper
  belongs_to :user, :foreign_key => "UserID"

  TYPE = { 0 => '积分转换',1 => '下单抵扣', 2 => '退单返回' }

end