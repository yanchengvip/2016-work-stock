class AddIsCheckedToCarts < ActiveRecord::Migration
  def change
    add_column :Carts, :is_checked, :boolean, default: true
  end
end
