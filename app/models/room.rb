class Room < ApplicationRecord
  belongs_to :hotel 
  has_many :bookings, dependent: :destroy

  # enum room_type: {
  #   apartment: 0,
  #   hotel_room: 1,
  #   home: 2,
  #   alternative_place: 3
  # }
  
  # enum parking: { bick: 0, car: 1, both: 2 }

end
