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

ActiveRecord::Schema.define(version: 20150408012929) do

  create_table "friend_requests", force: :cascade do |t|
    t.integer  "requester_id"
    t.integer  "requested_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "friend_requests", ["requested_id"], name: "index_friend_requests_on_requested_id"
  add_index "friend_requests", ["requester_id", "requested_id"], name: "index_friend_requests_on_requester_id_and_requested_id", unique: true
  add_index "friend_requests", ["requester_id"], name: "index_friend_requests_on_requester_id"

  create_table "friendships", force: :cascade do |t|
    t.integer  "friend_id"
    t.integer  "friendOf_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "friendships", ["friendOf_id"], name: "index_friendships_on_friendOf_id"
  add_index "friendships", ["friend_id", "friendOf_id"], name: "index_friendships_on_friend_id_and_friendOf_id", unique: true
  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id"

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "rating"
    t.string   "release_year"
    t.string   "genre"
    t.integer  "netflix_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_movies", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "user_id"
    t.boolean  "recently_viewed", default: true
    t.boolean  "liked"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "user_movies", ["movie_id"], name: "index_user_movies_on_movie_id"
  add_index "user_movies", ["user_id", "movie_id"], name: "index_user_movies_on_user_id_and_movie_id", unique: true
  add_index "user_movies", ["user_id"], name: "index_user_movies_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
