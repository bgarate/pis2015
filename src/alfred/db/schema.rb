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

ActiveRecord::Schema.define(version: 20150906225655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mentorships", force: :cascade do |t|
    t.date     "init_date"
    t.date     "finish_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "mentor_id"
    t.integer  "mentee_id"
  end

  add_index "mentorships", ["mentee_id"], name: "index_mentorships_on_mentee_id", using: :btree
  add_index "mentorships", ["mentor_id"], name: "index_mentorships_on_mentor_id", using: :btree

  create_table "milestones", force: :cascade do |t|
    t.string   "title"
    t.date     "due_date"
    t.date     "finish_date"
    t.text     "description"
    t.integer  "status"
    t.integer  "type"
    t.string   "icon"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text     "text"
    t.integer  "visibility"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.date     "init_date"
    t.date     "finish_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "celphone"
    t.string   "phone"
    t.date     "birth_date"
    t.date     "init_date"
    t.date     "finish_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "person_milestones", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "milestone_id"
    t.date     "finish_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "person_milestones", ["milestone_id"], name: "index_person_milestones_on_milestone_id", using: :btree
  add_index "person_milestones", ["person_id"], name: "index_person_milestones_on_person_id", using: :btree

  create_table "person_skills", force: :cascade do |t|
    t.date     "since_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "project_name"
    t.date     "init_date"
    t.date     "finish_date"
    t.string   "client"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "skill_name"
    t.integer  "skill_type"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tech_rols", force: :cascade do |t|
    t.string   "tech_rol_name"
    t.string   "icon"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "tech_name"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "mentorships", "people", column: "mentee_id"
  add_foreign_key "mentorships", "people", column: "mentor_id"
end
