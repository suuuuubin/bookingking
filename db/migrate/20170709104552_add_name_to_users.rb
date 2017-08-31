class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :image, :string
    
    add_column :users, :phone_number, :string
    add_column :users, :mileage, :integer
    add_column :users, :gender, :boolean #true 남자, false 여자
  end
end
