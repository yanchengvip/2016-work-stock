class CreateBarcodeHistories < ActiveRecord::Migration
  def change
    create_table :barcode_histories,id: false do |t|
      t.column :ID, "CHAR(36) primary key"
      t.column :UserID, "CHAR(36)"
      t.string :Code
      t.string :CreateBy
      t.string :UpdateBy
      t.datetime :CreateTime
      t.datetime :UpdateTime
    end
  end
end
