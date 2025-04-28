class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.string :title
      t.string :description
      t.integer :room_type
      t.integer :num_guests
      t.integer :num_rooms
      t.integer :num_beds
      t.integer :num_baths
      t.decimal :price_per_night
      t.boolean :self_check_in
      t.integer :parking
      t.boolean :kitchen
      t.boolean :washer
      t.boolean :dryer
      t.boolean :dishwasher
      t.boolean :wifi
      t.boolean :tv
      t.boolean :bathroom_essentials
      t.boolean :bedroom_comforts
      t.boolean :coffe_maker
      t.boolean :hair_dryer
      t.string :location
      t.integer :room_num

      t.timestamps
    end
  end
end
