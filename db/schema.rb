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

ActiveRecord::Schema.define(version: 20170817071431) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "user_id"
    t.integer  "table_id"
    t.string   "table_num"
    t.integer  "price"
    t.string   "dish",      default: "--- []\n"
    t.datetime "book_at"
    t.datetime "book_end"
    t.boolean  "checked",   default: false
  end

  create_table "menus", force: :cascade do |t|
    t.integer  "shop_id"
    t.string   "menu_name"
    t.integer  "price"
    t.integer  "popular"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "sender_shop"
    t.string   "receiver_id"
    t.text     "title"
    t.text     "content"
    t.boolean  "checked"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "shops", force: :cascade do |t|
    t.string   "shop_name"
    t.string   "shop_locate"
    t.integer  "seat_number"
    t.integer  "category"
    t.string   "shop_feature"
    t.string   "account_num"
    t.string   "open_time"
    t.string   "shop_num"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tables", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "table_num"
    t.integer  "table_size"
    t.integer  "table_state"
    t.string   "table_feature"
    t.datetime "book_at"
    t.datetime "book_end"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
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
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "phone_number"
    t.integer  "mileage"
    t.boolean  "gender"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
