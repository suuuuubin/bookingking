class Table < ActiveRecord::Base
    belongs_to :shop
    has_many :bookings
end
