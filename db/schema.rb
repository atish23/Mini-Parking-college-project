# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151019134512) do

  create_table "parking_lots", force: :cascade do |t|
    t.integer  "parking_id"
    t.boolean  "availaible"
    t.integer  "slot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "parking_lots", ["parking_id"], name: "index_parking_lots_on_parking_id"

  create_table "parkings", force: :cascade do |t|
    t.string   "name"
    t.decimal  "lat",            precision: 10, scale: 6
    t.decimal  "lng",            precision: 10, scale: 6
    t.integer  "total_capacity"
    t.integer  "filled"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.time     "in"
    t.time     "out"
    t.date     "date"
    t.integer  "payment"
    t.boolean  "payment_type"
    t.integer  "parking_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "transactions", ["parking_id"], name: "index_transactions_on_parking_id"
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",                       default: false
    t.string   "activation_digest"
    t.boolean  "activated",                   default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "car_number"
    t.integer  "mobile",            limit: 8
    t.string   "qrcode_uid"
    t.string   "qrcode_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
