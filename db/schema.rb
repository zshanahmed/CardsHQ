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

ActiveRecord::Schema.define(version: 20201126012646) do

  create_table "cards", force: :cascade do |t|
    t.string   "suit"
    t.string   "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "room_id"
    t.integer  "status"
  end

  add_index "cards", ["room_id"], name: "index_cards_on_room_id"
  add_index "cards", ["user_id"], name: "index_cards_on_user_id"

  create_table "hands", force: :cascade do |t|
    t.string   "suit"
    t.string   "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "card_id"
    t.integer  "user_id"
    t.integer  "room_id"
  end

  add_index "hands", ["card_id"], name: "index_hands_on_card_id"
  add_index "hands", ["room_id"], name: "index_hands_on_room_id"
  add_index "hands", ["user_id"], name: "index_hands_on_user_id"

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "invitation_token"
    t.integer  "card_id"
  end

  add_index "rooms", ["card_id"], name: "index_rooms_on_card_id"
  add_index "rooms", ["name"], name: "index_rooms_on_name", unique: true

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "session_token"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.integer  "room_id"
    t.integer  "card_id"
    t.string   "score"
    t.string   "provider"
    t.string   "uid"
    t.text     "image"
  end

  add_index "users", ["card_id"], name: "index_users_on_card_id"
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["room_id"], name: "index_users_on_room_id"

end
