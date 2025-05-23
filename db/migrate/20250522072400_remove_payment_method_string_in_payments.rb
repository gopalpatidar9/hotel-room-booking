class RemovePaymentMethodStringInPayments < ActiveRecord::Migration[8.0]
  def change
    remove_column :payments, :paymet_method, :string
  end
end
