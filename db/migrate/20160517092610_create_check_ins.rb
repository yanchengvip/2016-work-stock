class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :CheckIns, id: false do |t|
      t.column :ID, "char(36)", primary: true, null: false
      t.column :UserID, "char(36)", index: true
      t.column :CheckInDate, :date

      t.timestamps null: false
    end

    add_index :CheckIns, [:UserID, :CheckInDate], unique: true
  end
end
