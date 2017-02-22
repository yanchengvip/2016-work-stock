class AddMaxSaleAmountDayToProducts < ActiveRecord::Migration
  def change
    add_column :Products, :MaxSaleAmountDay, :integer
  end
end
