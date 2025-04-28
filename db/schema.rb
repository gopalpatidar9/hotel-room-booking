# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_26_091015) do
  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "num_guests"
    t.decimal "total_prcie"
    t.decimal "gst"
    t.datetime "canceled_at"
    t.string "payment_method"
    t.string "payment_status"
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id", null: false
    t.integer "user_id", null: false
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "hotel_name"
    t.string "loaction"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_hotels_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, default: "0.0"
    t.string "paymet_method"
    t.string "payment_status"
    t.datetime "paid_at"
    t.string "stripe_payment_id"
    t.string "stripe_checkout_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "booking_id", null: false
    t.index ["booking_id"], name: "index_payments_on_booking_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "room_type"
    t.integer "num_guests"
    t.integer "num_rooms"
    t.integer "num_beds"
    t.integer "num_baths"
    t.decimal "price_per_night"
    t.boolean "self_check_in"
    t.integer "parking"
    t.boolean "kitchen"
    t.boolean "washer"
    t.boolean "dryer"
    t.boolean "dishwasher"
    t.boolean "wifi"
    t.boolean "tv"
    t.boolean "bathroom_essentials"
    t.boolean "bedroom_comforts"
    t.boolean "coffe_maker"
    t.boolean "hair_dryer"
    t.string "location"
    t.integer "room_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hotel_id", null: false
    t.index ["hotel_id"], name: "index_rooms_on_hotel_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "mobile_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "rooms"
  add_foreign_key "bookings", "users"
  add_foreign_key "hotels", "users"
  add_foreign_key "payments", "bookings"
  add_foreign_key "payments", "users"
  add_foreign_key "rooms", "hotels"
end
