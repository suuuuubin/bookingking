class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      
      t.string :shop_name
      t.string :shop_locate
      t.integer :seat_number
      t.integer :category
      
      t.string :shop_feature
      
      t.string :account_num
      t.string :open_time
      t.string :shop_num
      
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end
