class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.decimal :amount, precision: 10, scale: 2, default: "0.0"
      t.string :paymet_method
      t.string :payment_status
      t.datetime :paid_at
      t.string :stripe_payment_id
      t.string :stripe_checkout_url

      t.timestamps
    end
  end
end
