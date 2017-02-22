class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :Invitations, id: false do |t|
      t.string :ID, limit: 36, primary: true, null: false
      t.string :UserID, limit: 36, index: true
      t.string :Phone

      t.datetime :CreateTime
      t.datetime :UpdateTime
    end

    add_index :Invitations, :Phone, unique: true
  end
end
