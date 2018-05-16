# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180516145427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_players", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "user_id"
    t.boolean "player_pay_status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.index ["booking_id"], name: "index_booking_players_on_booking_id"
    t.index ["user_id"], name: "index_booking_players_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "field_id"
    t.datetime "date"
    t.string "status"
    t.integer "number_players"
    t.boolean "splitable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "balance_cents", default: 0, null: false
    t.index ["field_id"], name: "index_bookings_on_field_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.string "phone"
    t.integer "rating"
    t.string "nit"
    t.string "bank_name"
    t.string "bank_account_type"
    t.string "bank_account_number"
    t.string "photo"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "opening", default: 8
    t.integer "closing", default: 22
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "name"
    t.bigint "business_id"
    t.integer "capacity"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.index ["business_id"], name: "index_fields_on_business_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.boolean "business_owner", default: false
    t.string "provider"
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.string "token"
    t.datetime "token_expiracy"
    t.string "phone"
    t.string "colombian_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "booking_players", "bookings"
  add_foreign_key "booking_players", "users"
  add_foreign_key "bookings", "fields"
  add_foreign_key "businesses", "users"
  add_foreign_key "fields", "businesses"
end
