class CreateHotels < ActiveRecord::Migration[8.0]
  def change
    create_table :hotels do |t|
      t.string :hotel_name
      t.string :loaction
      t.string :description

      t.timestamps
    end
  end
end
