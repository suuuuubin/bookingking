class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      
      t.integer :shop_id
      
      t.integer :table_num 
      
      t.integer :table_size
      t.integer :table_state
      
      t.string :table_feature
      
      t.datetime :book_at
      t.datetime :book_end
      
    end
  end
end
