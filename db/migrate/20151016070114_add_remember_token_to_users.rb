class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :Users, :RememberToken, :string
  end
end
