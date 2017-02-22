class AddOrderGroupIdToOrders < ActiveRecord::Migration
  def change
    add_column :Orders, :OrderGroupID, "char(36)"
  end
end
