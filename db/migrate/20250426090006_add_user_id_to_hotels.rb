class AddUserIdToHotels < ActiveRecord::Migration[8.0]
  def change
    add_reference :hotels, :user, null: false, foreign_key: true
  end
end
