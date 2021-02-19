# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_18_214745) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "date_of_birth"
    t.string "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "race"
    t.string "ethnicity"
    t.string "email"
    t.string "phone_number"
  end

  create_table "incident_reports", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.text "description"
    t.datetime "occurred_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reporter_id"
    t.index ["client_id"], name: "index_incident_reports_on_client_id"
    t.index ["reporter_id"], name: "index_incident_reports_on_reporter_id"
  end

  create_table "intakes", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.json "survey"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_intakes_on_client_id"
    t.index ["user_id"], name: "index_intakes_on_user_id"
  end

  create_table "motels", force: :cascade do |t|
    t.string "name", null: false
    t.json "address"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "swap_periods", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: false, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vouchers", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.bigint "motel_id", null: false
    t.datetime "check_in", null: false
    t.datetime "check_out", null: false
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "swap_period_id"
    t.index ["client_id"], name: "index_vouchers_on_client_id"
    t.index ["motel_id"], name: "index_vouchers_on_motel_id"
    t.index ["swap_period_id"], name: "index_vouchers_on_swap_period_id"
    t.index ["user_id"], name: "index_vouchers_on_user_id"
  end

  add_foreign_key "incident_reports", "clients"
  add_foreign_key "incident_reports", "users", column: "reporter_id"
  add_foreign_key "intakes", "clients"
  add_foreign_key "intakes", "users"
  add_foreign_key "vouchers", "clients"
  add_foreign_key "vouchers", "motels"
  add_foreign_key "vouchers", "swap_periods"
  add_foreign_key "vouchers", "users"
end
