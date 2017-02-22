class CreateOrderCoupons < ActiveRecord::Migration
  def change
    create_table :order_coupons, id: false do |t|
      t.column :ID, "CHAR(36) primary key"
      t.column :OrderID, "CHAR(36)", index: true
      t.column :UserID, "CHAR(36)", index: true
      t.column :UserCouponID, "CHAR(36)", index: true
      t.column :CouponID, "CHAR(36)", index: true
      t.column :CouponPrice, "DECIMAL(18,2)"
      t.datetime :CreateTime
      t.datetime :UpdateTime
    end
  end
end
