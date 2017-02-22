class AddCurrentActivityAmountToProducts < ActiveRecord::Migration
  def change
    add_column :Products, :CurrentActivityAmount, :integer
  end
end
