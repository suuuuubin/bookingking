class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :sender_shop
      t.string :receiver_id
      
      t.text :title
      t.text :content
      
      t.boolean :checked
      
      t.timestamps null: false
    end
  end
end
