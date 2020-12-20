# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_20_161134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "spotify_user_id"
    t.string "email"
    t.boolean "expires"
    t.integer "expires_at"
    t.text "refresh_token"
    t.text "token"
    t.text "playlist_id"
    t.string "user_token"
    t.string "phone_number"
    t.string "last_request"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language"
  end

end
