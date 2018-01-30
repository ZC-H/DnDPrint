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

ActiveRecord::Schema.define(version: 20180130113840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sheets", force: :cascade do |t|
    t.string "name"
    t.string "race"
    t.string "gender"
    t.string "background"
    t.string "class"
    t.integer "hp"
    t.integer "level"
    t.integer "initiative"
    t.integer "ac"
    t.text "abilityscores", default: [nil, nil, nil, nil, nil, nil], array: true
    t.text "saveprofs", default: [], array: true
    t.text "skillmods", default: ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"], array: true
    t.text "skillprofs", default: [], array: true
    t.text "classfeatures", default: [], array: true
    t.text "attacks", default: [], array: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sheets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
  end

end
