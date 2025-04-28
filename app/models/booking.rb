class Booking < ApplicationRecord
  belons_to :room  
  belongs_to :user
end
