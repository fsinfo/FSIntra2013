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

ActiveRecord::Schema.define(version: 20130416071841) do

  create_table "beverage_tabs", force: true do |t|
    t.integer  "tab_id"
    t.integer  "count"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.decimal  "capacity",   precision: 8, scale: 2
  end

  create_table "beverages", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "available"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "capacity",    precision: 8, scale: 2
  end

  create_table "invitees", id: false, force: true do |t|
    t.integer "minute_id"
    t.integer "user_id"
    t.string  "absent"
  end

  create_table "minutes", force: true do |t|
    t.datetime "date"
    t.string   "status",                   default: "draft"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "keeper_of_the_minutes_id"
    t.integer  "chairperson_id"
  end

  create_table "minutes_guests", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "minutes_items", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "minute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  create_table "minutes_minute_approve_items", force: true do |t|
    t.integer  "order"
    t.integer  "minute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "minutes_minute_approve_motions", force: true do |t|
    t.integer  "pro"
    t.integer  "abs"
    t.integer  "con"
    t.integer  "minute_approve_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "minute_id"
  end

  create_table "minutes_minutes_guests", id: false, force: true do |t|
    t.integer "guest_id"
    t.integer "minute_id"
  end

  create_table "minutes_motions", force: true do |t|
    t.text     "rationale"
    t.integer  "mover_id"
    t.decimal  "amount"
    t.integer  "pro"
    t.integer  "abs"
    t.integer  "con"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
  end

  add_index "minutes_motions", ["mover_id"], name: "index_minutes_motions_on_mover_id"

  create_table "people", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.date     "birthday"
    t.text     "misc"
    t.string   "loginname"
    t.string   "remember_token"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tabs", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
  end

  create_table "user_tabs", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "tab_id"
  end

  add_index "user_tabs", ["user_id", "tab_id"], name: "index_user_tabs_on_user_id_and_tab_id", unique: true

  create_table "users", force: true do |t|
    t.string   "loginname"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.date     "birthday"
    t.text     "misc"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
