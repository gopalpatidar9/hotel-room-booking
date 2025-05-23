class RenamePaymentMethodInPayments < ActiveRecord::Migration[8.0]
  def change
    rename_column :payments, :payment_method, :pay_method
    rename_column :payments, :payment_status, :pay_status
  end
end
