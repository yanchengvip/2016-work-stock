class AddCouponPriceAndTypeIdAndRemarkToInvitations < ActiveRecord::Migration
  def change
    add_column :Invitations, :CouponPrice, :float
    add_column :Invitations, :UseMoney, :float, :default => 500
    add_column :Invitations, :TypeID, :integer
    add_column :Invitations, :Remark, :string

    Invitation.update_all(CouponPrice: 25, TypeID: 0, Remark: '分享成功')
  end
end
