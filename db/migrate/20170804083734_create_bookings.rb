class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      
      t.integer :shop_id
      t.integer :user_id
      t.integer :table_id
      
      t.string :table_num
      t.integer :price
      
      t.string :dish, array: true, default: []
      
      t.datetime :book_at
      t.datetime :book_end
      
      t.boolean :checked, default: false
    end
  end
end
