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

ActiveRecord::Schema.define(version: 20180114041858) do

  create_table "adventures", force: :cascade do |t|
    t.string "number_of_people"
    t.string "action_adventure"
    t.string "country"
    t.string "city"
    t.string "description"
    t.string "details"
    t.datetime "adventure_date"
    t.float "price"
    t.datetime "created_at"
    t.boolean "completed"
    t.integer "user_id"
    t.boolean "paid"
    t.integer "inviter"
    t.float "earned"
    t.integer "conducted_by"
    t.integer "rating"
    t.string "state"
    t.string "method"
    t.index ["user_id"], name: "index_adventures_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.integer "user_id"
    t.integer "host_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "adventure"
  end

  create_table "comments", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.text "capabilities"
    t.float "price"
    t.integer "adventure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "image"
    t.index ["adventure_id"], name: "index_comments_on_adventure_id"
  end

  create_table "friendships", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_user_id"
    t.index ["friend_user_id", "user_id"], name: "index_friendships_on_friend_user_id_and_user_id", unique: true
    t.index ["user_id", "friend_user_id"], name: "index_friendships_on_user_id_and_friend_user_id", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.integer "user_id"
    t.integer "chat_room_id"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.datetime "date_of_birth"
    t.string "country_of_residence"
    t.string "city_of_residence"
    t.string "contact_phone"
    t.string "education"
    t.string "work"
    t.string "interests"
    t.string "capabilities"
    t.boolean "admin"
    t.integer "gave_actions"
    t.integer "gave_advices"
    t.integer "asked_actions"
    t.integer "asked_advices"
    t.string "state"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
