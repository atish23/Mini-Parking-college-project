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

ActiveRecord::Schema.define(version: 20151107151009) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.integer  "parking_id"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

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
    t.integer  "cost"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "in"
    t.datetime "out"
    t.datetime "date"
    t.integer  "payment"
    t.boolean  "payment_type"
    t.boolean  "current_transaction"
    t.integer  "parking_id"
    t.integer  "parking_lot_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.boolean  "currently_in"
  end

  add_index "transactions", ["parking_id"], name: "index_transactions_on_parking_id"
  add_index "transactions", ["parking_lot_id"], name: "index_transactions_on_parking_lot_id"
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "password_digest"
    t.string   "remember_digest"
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
