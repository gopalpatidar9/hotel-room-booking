class Room < ApplicationRecord
  belongs_to :hotel 
  has_may :bookings, dependent: :destroy
end
