class AddColumnsInHotel < ActiveRecord::Migration[8.0]
  def change
    add_column :hotels, :city, :string
    add_column :hotels, :state, :string
    add_column :hotels, :country, :string
  end
end
