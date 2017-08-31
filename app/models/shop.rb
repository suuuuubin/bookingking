class Shop < ActiveRecord::Base
    has_many :menus
    has_many :tables

end
