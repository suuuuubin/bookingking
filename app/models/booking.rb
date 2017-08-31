class Booking < ActiveRecord::Base
    
    resourcify
    
    belongs_to :shop
    belongs_to :user
    belongs_to :table
    
    serialize :dish, Array
end