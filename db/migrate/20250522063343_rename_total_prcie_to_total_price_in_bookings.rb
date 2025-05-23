class RenameTotalPrcieToTotalPriceInBookings < ActiveRecord::Migration[8.0]
  def change
    rename_column :bookings, :total_prcie, :total_price
  end
end
