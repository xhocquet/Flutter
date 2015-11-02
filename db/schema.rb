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

ActiveRecord::Schema.define(version: 20151102015045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animes", force: :cascade do |t|
    t.date     "end_air_date"
    t.date     "start_air_date"
    t.float    "community_rating"
    t.integer  "episode_count"
    t.integer  "episode_length"
    t.integer  "hm_id"
    t.integer  "mal_id"
    t.string   "age_rating"
    t.string   "cover_image_url"
    t.string   "hm_url"
    t.string   "show_type"
    t.string   "status"
    t.string   "title"
    t.text     "synopsis"
    t.string   "slug"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "animes_genres", id: false, force: :cascade do |t|
    t.integer "anime_id", null: false
    t.integer "genre_id", null: false
  end

  add_index "animes_genres", ["anime_id", "genre_id"], name: "index_animes_genres_on_anime_id_and_genre_id", unique: true, using: :btree

  create_table "genres", force: :cascade do |t|
    t.string "name"
  end

  create_table "library_entries", force: :cascade do |t|
    t.date     "last_date_watched"
    t.float    "rating"
    t.integer  "episodes_watched"
    t.integer  "hm_id"
    t.integer  "times_rewatched"
    t.string   "status"
    t.string   "title"
    t.string   "name"
    t.integer  "anime_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "library_entries", ["anime_id"], name: "index_library_entries_on_anime_id", using: :btree
  add_index "library_entries", ["user_id"], name: "index_library_entries_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.date     "last_date_updated"
    t.float    "mean_rating"
    t.integer  "number_of_entries"
    t.integer  "number_of_episodes"
    t.integer  "time_spent_on_anime"
    t.string   "avatar"
    t.string   "cover_image"
    t.string   "name"
    t.string   "hm_dash_url"
    t.string   "hm_library_url"
    t.string   "time_string"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "time_can_refresh"
  end

end
