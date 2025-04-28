class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :num_guests
      t.decimal :total_prcie
      t.decimal :gst
      t.datetime :canceled_at
      t.string :payment_method
      t.string :payment_status
      t.string :transaction_id

      t.timestamps
    end
  end
end
