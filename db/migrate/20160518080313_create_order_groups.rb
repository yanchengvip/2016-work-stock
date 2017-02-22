class CreateOrderGroups < ActiveRecord::Migration
  def change
    create_table :OrderGroups, id: false do |t|
      t.column :ID, "char(36) primary key"
      t.column :UserID, "char(36)", index: true
      t.column :Status, :integer

      t.timestamps null: false
    end
  end
end
