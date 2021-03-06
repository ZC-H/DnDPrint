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

ActiveRecord::Schema.define(version: 20180201190350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sheets", force: :cascade do |t|
    t.string "name"
    t.string "race"
    t.string "gender"
    t.string "campaign"
    t.string "background"
    t.string "classes"
    t.integer "hp"
    t.integer "level"
    t.integer "initiative"
    t.integer "ac"
    t.integer "profbonus"
    t.text "abilityscores"
    t.text "saves"
    t.text "skillmods"
    t.text "classfeatures"
    t.text "attacks"
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
    t.string "auth_token"
  end

end
