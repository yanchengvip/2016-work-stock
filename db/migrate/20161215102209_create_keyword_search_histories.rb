class CreateKeywordSearchHistories < ActiveRecord::Migration
  def change
    create_table :keyword_search_histories,id: false do |t|
      t.column :ID,"CHAR(36) primary key"
      t.column :UserID,"CHAR(36)",index: true
      t.string :KeyWordName
      t.datetime :CreateTime
      t.datetime :UpdateTime
    end
  end
end
