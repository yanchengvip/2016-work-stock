=begin
 create_table "PointHistories", force: :cascade do |t|
    t.string   "UserID",       limit: 255
    t.integer  "CurrentPoint", limit: 4
    t.integer  "DeltaPoint",   limit: 4
    t.integer  "Type",         limit: 4
    t.datetime "CreateTime"
    t.datetime "UpdateTime"
  end
=end
class PointHistory < ActiveRecord::Base
  self.table_name = 'PointHistories'
  include UUIDHelper
  belongs_to :user, :foreign_key => "UserID"
  TYPE = { 0 => '进货奖励', 1 => '退货扣除', 2 => '兑换商品', 3 => '抽奖消耗', 4 => '抽奖获取', 5 => '下单抵扣', 6 => '退单返回', 7 => '满万返百', 8 => '系统赠送', 9 => '活动分享' }

  def type_tos
    TYPE[self.Type]
  end

  # 抽奖积分操作
  def exchange_point options
     # options = {user_id:'',delete_point:'',type:'',add_point:'',coupon_price:'',use_money:''}
     user_id = options[:user_id]
     del_point = options[:del_point]
     type = options[:type]
     add_point = options[:add_point]
     coupon_price = options[:coupon_price]
     use_money = options[:use_money]
     days = options[:days]
     is_festival = options[:is_festival]
      if is_festival
        # 区分端午节抽奖历史记录
        prize_name = type == 1 ? '父亲节---获取进货宝'+add_point.to_s+'积分':'父亲节---获取进货宝'+coupon_price.to_s+'元优惠券'
      else
        prize_name = type == 1 ? '获取进货宝'+add_point.to_s+'积分':'获取进货宝'+coupon_price.to_s+'元优惠券'
      end

     flag =false
     ActiveRecord::Base.transaction do
       current_user = User.find_by(ID:user_id).lock!
       return {status:'error',message:'积分不足'} if current_user.nil? || current_user.Integral.to_i < del_point
       current_user.increment_with_sql!(:Integral, -del_point)
       # 抽奖消耗
       PointHistory.create!(UserID:user_id,CurrentPoint:current_user.Integral.to_i,DeltaPoint:-del_point,Type:3) if del_point.to_i > 0
       # 抽奖获取
       if type == 1
         #PointLottery表 Type=1赠送的积分
        PointHistory.create!(UserID:user_id,CurrentPoint:current_user.Integral.to_i + add_point, DeltaPoint:add_point,Type:4)
        current_user.increment_with_sql!(:Integral, add_point)
       end
       # 抽奖历史
       LotteryHistory.create!( UserID:user_id,PrizeName:prize_name)
       # 抽奖优惠现金券
       if type == 0
         #options[:type]=0赠送的是优惠现金券
         UserCoupon.create!(UsersID:user_id,Price:coupon_price,Status:1,Type:0,Source:0,UseMoney:use_money,StartDate:Date.today,EndDate:Date.today + days + 23.hour + 59.minutes + 59.second ,Cause: '积分抽奖')
       end
       flag =true
     end
     return {status:'ok',message:''} if flag == true
     return {status:'error',message:'保存失败'}
  end
end
