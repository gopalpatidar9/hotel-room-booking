class ChangePaymentStatusToIntegerInPayments < ActiveRecord::Migration[8.0]
  def change
    remove_column :payments, :payment_status, :string
    add_column :payments, :payment_status, :integer, default: 0
  end
end
