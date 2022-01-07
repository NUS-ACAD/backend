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

ActiveRecord::Schema.define(version: 2022_01_07_113933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feeds", force: :cascade do |t|
    t.integer "user_id"
    t.text "activity_type"
    t.integer "plan_id"
    t.integer "second_plan_id"
    t.integer "group_id"
    t.text "raw_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invites", force: :cascade do |t|
    t.integer "invitee_id"
    t.integer "group_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "plan_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "plan_id"], name: "index_likes_on_user_id_and_plan_id", unique: true
  end

  create_table "members", force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.boolean "is_owner", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id", "user_id"], name: "index_members_on_group_id_and_user_id", unique: true
  end

  create_table "mods", force: :cascade do |t|
    t.integer "semester_id"
    t.string "module_code"
    t.text "additional_desc"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "module_title"
    t.index ["semester_id", "module_code"], name: "index_mods_on_semester_id_and_module_code", unique: true
  end

  create_table "plans", force: :cascade do |t|
    t.integer "owner_id"
    t.integer "forked_plan_source_id"
    t.boolean "is_primary"
    t.integer "start_year"
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "semesters", force: :cascade do |t|
    t.integer "plan_id"
    t.integer "year"
    t.integer "semester_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "primary_degree"
    t.string "second_degree"
    t.string "second_major"
    t.string "first_minor"
    t.string "second_minor"
    t.integer "matriculation_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  add_foreign_key "feeds", "users"
  add_foreign_key "follows", "users", column: "followed_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "invites", "groups"
  add_foreign_key "invites", "users", column: "invitee_id"
  add_foreign_key "likes", "plans"
  add_foreign_key "likes", "users"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "users"
  add_foreign_key "mods", "semesters"
  add_foreign_key "plans", "plans", column: "forked_plan_source_id"
  add_foreign_key "plans", "users", column: "owner_id"
  add_foreign_key "semesters", "plans"
end
