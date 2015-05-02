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

ActiveRecord::Schema.define(version: 20150412184103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "server_group_members", force: :cascade do |t|
    t.integer  "server_group_id"
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "server_group_members", ["server_group_id"], name: "index_server_group_members_on_server_group_id", using: :btree
  add_index "server_group_members", ["user_id"], name: "index_server_group_members_on_user_id", using: :btree

  create_table "server_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "server_groups", ["project_id"], name: "index_server_groups_on_project_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",                                    null: false
    t.string   "name"
    t.string   "email",                                       null: false
    t.string   "encrypted_password", limit: 128,              null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,              null: false
    t.string   "preferred_shell",                             null: false
    t.text     "ssh_public_key",                 default: ""
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "server_group_members", "server_groups"
  add_foreign_key "server_group_members", "users"
  add_foreign_key "server_groups", "projects"
end
