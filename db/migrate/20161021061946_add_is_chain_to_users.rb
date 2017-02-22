class AddIsChainToUsers < ActiveRecord::Migration
  def change
    add_column :users, :IsChain, :boolean
  end
end
