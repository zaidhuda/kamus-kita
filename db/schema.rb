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

ActiveRecord::Schema.define(version: 20170415180659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "definitions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "word_id"
    t.text     "definition"
    t.text     "example"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "hidden",           default: false
    t.integer  "likes_counter",    default: 0,     null: false
    t.integer  "dislikes_counter", default: 0,     null: false
    t.string   "original_word"
    t.index ["hidden"], name: "index_definitions_on_hidden", using: :btree
    t.index ["user_id"], name: "index_definitions_on_user_id", using: :btree
    t.index ["word_id", "dislikes_counter"], name: "index_definitions_on_word_id_and_dislikes_counter", using: :btree
    t.index ["word_id", "likes_counter"], name: "index_definitions_on_word_id_and_likes_counter", using: :btree
    t.index ["word_id"], name: "index_definitions_on_word_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "handle"
    t.citext   "slug"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "definition_id"
    t.boolean  "like"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["definition_id", "like"], name: "index_votes_on_definition_id_and_like", using: :btree
    t.index ["definition_id"], name: "index_votes_on_definition_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

  create_table "words", force: :cascade do |t|
    t.string   "word"
    t.citext   "slug"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "hidden",     default: false
    t.index ["hidden"], name: "index_words_on_hidden", using: :btree
    t.index ["slug"], name: "index_words_on_slug", using: :btree
    t.index ["word"], name: "index_words_on_word", using: :btree
  end

  add_foreign_key "definitions", "users"
  add_foreign_key "definitions", "words"
  add_foreign_key "votes", "definitions"
  add_foreign_key "votes", "users"
end
