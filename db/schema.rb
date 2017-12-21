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

ActiveRecord::Schema.define(version: 20171221165347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "appearances", force: :cascade do |t|
    t.integer  "chapter_id"
    t.integer  "character_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "place_id"
    t.index ["chapter_id"], name: "index_appearances_on_chapter_id", using: :btree
    t.index ["character_id"], name: "index_appearances_on_character_id", using: :btree
    t.index ["place_id"], name: "index_appearances_on_place_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "genre"
    t.datetime "deadline"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "word_goal"
    t.integer  "max_streaks"
    t.integer  "current_streaks"
    t.integer  "max_daily_wordcount"
    t.index ["user_id"], name: "index_books_on_user_id", using: :btree
  end

  create_table "chapters", force: :cascade do |t|
    t.text     "content"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.integer  "position"
    t.index ["book_id"], name: "index_chapters_on_book_id", using: :btree
  end

  create_table "characters", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "position"
    t.text     "comments"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_characters_on_book_id", using: :btree
  end

  create_table "daily_word_counts", force: :cascade do |t|
    t.integer  "wordcount"
    t.integer  "book_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "total_word_count"
    t.index ["book_id"], name: "index_daily_word_counts_on_book_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_places_on_book_id", using: :btree
  end

  create_table "streaks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "book_id"
    t.index ["book_id"], name: "index_streaks_on_book_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "appearances", "chapters"
  add_foreign_key "appearances", "characters"
  add_foreign_key "appearances", "places"
  add_foreign_key "books", "users"
  add_foreign_key "chapters", "books"
  add_foreign_key "characters", "books"
  add_foreign_key "daily_word_counts", "books"
  add_foreign_key "places", "books"
  add_foreign_key "streaks", "books"
end
