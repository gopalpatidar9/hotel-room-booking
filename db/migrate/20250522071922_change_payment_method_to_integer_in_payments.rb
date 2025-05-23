class ChangePaymentMethodToIntegerInPayments < ActiveRecord::Migration[8.0]
  def change
    remove_column :payments, :payment_method, :string
    add_column :payments, :payment_method, :integer, default: 0
  end
end
