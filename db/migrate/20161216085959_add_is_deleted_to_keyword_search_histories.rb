class AddIsDeletedToKeywordSearchHistories < ActiveRecord::Migration
  def change
    add_column :keyword_search_histories, :IsDeleted, :boolean,default: false
  end
end
