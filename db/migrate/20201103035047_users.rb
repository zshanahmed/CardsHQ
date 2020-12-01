class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.timestamps null: false
    end
    add_index :users, :username, unique: true
  end
end

#
# create_table "users", force: :cascade do |t|
#     t.string   "username"
#     t.string   "email"
#     t.string   "password"
#     t.string   "session_token"
#     t.string   "invitation_token"
#     t.datetime "invitation_created_at"
#     t.datetime "invitation_sent_at"
#     t.datetime "invitation_accepted_at"
#     t.integer  "invitation_limit"
#     t.integer  "invited_by_id"
#     t.string   "invited_by_type"
#     t.integer  "invitations_count",      default: 0
#     t.integer  "room_id"
#     t.integer  "card_id"
#     t.string   "score"
#   end