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

ActiveRecord::Schema.define(version: 2022_01_17_123643) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "declutter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "declutter_comments", force: :cascade do |t|
    t.text "comment"
    t.integer "user_id"
    t.integer "declutter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "declutters", force: :cascade do |t|
    t.string "title"
    t.string "thing_image_id"
    t.text "caption"
    t.integer "user_id"
    t.integer "point"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "declutter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "next_levels", force: :cascade do |t|
    t.integer "level"
    t.integer "thresold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_image_id"
    t.text "introduction"
    t.integer "level", default: 1
    t.integer "exp_point", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
