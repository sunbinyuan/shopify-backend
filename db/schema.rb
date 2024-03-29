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

ActiveRecord::Schema.define(version: 2019_01_19_032116) do

  create_table "access_tokens", force: :cascade do |t|
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.string "cart_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_carts_on_cart_id", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "title", null: false
    t.decimal "price", null: false
    t.bigint "inventory_count", null: false
    t.text "description"
    t.string "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_items_on_item_id", unique: true
  end

  create_table "specific_carts", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "item_id"
    t.bigint "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_specific_carts_on_cart_id"
    t.index ["item_id"], name: "index_specific_carts_on_item_id"
  end

end
