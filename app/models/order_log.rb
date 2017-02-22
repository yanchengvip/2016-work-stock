# == Schema Information
#
# Table name: OrderLogs
#
#  ID                :string(36)       default(""), not null, primary key
#  OrderId           :string(36)
#  LogType           :integer          not null
#  OperationDate     :datetime         not null
#  OperationItCode   :string(255)
#  OperationUserName :string(255)
#  Remark            :text(4294967295)
#  CreateTime        :datetime
#  CreateBy          :string(100)
#  UpdateTime        :datetime
#  UpdateBy          :string(100)
#  IP                :string(255)
#  Agent             :string(255)
#

class OrderLog < ActiveRecord::Base
  self.table_name = 'OrderLogs'
  belongs_to :order, :foreign_key => 'OrderId'

  include UUIDHelper

  def logistics_status
    case self.Remark
    when /确认订单/
      "订单已经提交由#{self.OperationUserName}确认"
    when '打印四联单'
      "订单已经提交由#{self.OperationUserName}打印"
    when '确认打印完成'
      '订单正在配货'
    when /订单发货|已发出/
      str = ''
      if self.order.DriverName.present?
        str = "订单由#{self.order.DriverName.first}师傅正在为您配送"
        str += "，电话: #{self.order.DriverMobile}"
      else
        str = '订单正在由司机配送'
      end
      str
    when /.*确认收款.*/
      '订单已签收，感谢您的支持'
    end
  end
end
