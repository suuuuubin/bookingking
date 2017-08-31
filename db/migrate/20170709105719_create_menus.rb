class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      
      t.integer :shop_id
      
      t.string :menu_name
      t.integer :price
      t.integer :popular
      
      t.timestamps null: false
    end
  end
end

