class AddThirdTypeToCarts < ActiveRecord::Migration
  def change
    add_column :Carts, :ThirdType, "int(2) unsigned zerofill", default: 00

    Cart.where("ThirdType is null").update_all("ThirdType = 0")
  end
end
