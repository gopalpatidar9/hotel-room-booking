class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[8.0]
  def change 
    change_table :users, bulk: true do |t|
      # These are the columns needed for devise_token_auth
      t.string :provider, default: 'email', null: false
      t.string :uid, null: false, default: ''
      t.text :tokens
    end
  end
end
