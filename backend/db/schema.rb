# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_01_15_025321) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"

  create_table "albums", primary_key: "album_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.datetime "public_at"
    t.boolean "status", default: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "followings", id: false, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "follower_id", null: false
    t.uuid "following_id", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_followings_on_follower_id"
    t.index ["following_id"], name: "index_followings_on_following_id"
  end

  create_table "photos", primary_key: "photo_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "album_id", null: false
    t.string "description"
    t.datetime "public_at", default: -> { "now()" }
    t.boolean "status", default: false
    t.string "title", null: false
    t.datetime "upload_at", default: -> { "now()" }
    t.string "url"
    t.uuid "user_id", null: false
    t.index ["album_id"], name: "index_photos_on_album_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "users", primary_key: "uid", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "email", null: false
    t.boolean "enable_google_login"
    t.string "fname", null: false
    t.string "lname", null: false
    t.string "password", null: false
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["fname", "lname"], name: "index_users_on_fname_and_lname", opclass: :gist_trgm_ops, using: :gist
  end

  add_foreign_key "albums", "users", primary_key: "uid"
  add_foreign_key "followings", "users", column: "follower_id", primary_key: "uid"
  add_foreign_key "followings", "users", column: "following_id", primary_key: "uid"
  add_foreign_key "photos", "albums", primary_key: "album_id"
  add_foreign_key "photos", "users", primary_key: "uid"
end
