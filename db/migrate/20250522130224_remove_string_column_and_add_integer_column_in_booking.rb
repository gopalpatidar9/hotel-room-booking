class RemoveStringColumnAndAddIntegerColumnInBooking < ActiveRecord::Migration[8.0]
  def change
    remove_column :bookings, :payment_method, :string
    remove_column :bookings, :payment_status, :string

    add_column :bookings, :payment_method, :integer, default: 0
    add_column :bookings, :payment_status, :integer, default: 0
  end
end
