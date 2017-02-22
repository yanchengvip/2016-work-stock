class AddIsDeletedToBarcodeHistories < ActiveRecord::Migration
  def change
    add_column :barcode_histories, :IsDeleted, :boolean,default: false
  end
end
