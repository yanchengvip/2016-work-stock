class AddSupplementsToUserAddresses < ActiveRecord::Migration
  def change
    add_column :UserAddresses, :Supplements, :string
  end
end
