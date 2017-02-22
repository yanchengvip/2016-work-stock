class AddCompanyIdToCarts < ActiveRecord::Migration
  def change
    add_column :Carts, :CompanyID, :string, length: 36

    Cart.update_all(CompanyID: City.beijing.CompanyID)
  end
end
