class AddRoomIdToBookings < ActiveRecord::Migration[8.0]
  def change
    add_reference :bookings, :room, null: false, foreign_key: true
  end
end
