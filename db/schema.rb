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

ActiveRecord::Schema.define(version: 20130408153509) do

  create_table "beverage_tabs", force: true do |t|
    t.integer  "beverage_id"
    t.integer  "tab_id"
    t.integer  "count"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beverages", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "available"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "minutes", force: true do |t|
    t.datetime "date"
    t.string   "status",     default: "draft"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tabs", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
