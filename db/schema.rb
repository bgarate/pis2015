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

ActiveRecord::Schema.define(version: 20151007130245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mentorships", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "mentor_id"
    t.integer  "mentee_id"
  end

  add_index "mentorships", ["mentee_id", "mentor_id"], name: "index_mentorships_on_mentee_id_and_mentor_id", unique: true, using: :btree
  add_index "mentorships", ["mentee_id"], name: "index_mentorships_on_mentee_id", using: :btree
  add_index "mentorships", ["mentor_id"], name: "index_mentorships_on_mentor_id", using: :btree

  create_table "milestone_templates", force: :cascade do |t|
    t.string   "title"
    t.integer  "due_term"
    t.text     "description"
    t.integer  "type"
    t.string   "icon"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "milestones", force: :cascade do |t|
    t.string   "title"
    t.date     "due_date"
    t.text     "description"
    t.integer  "status",             default: 0
    t.string   "icon"
    t.integer  "feedback_author_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "category_id"
    t.date     "start_date"
  end

  create_table "milestones_tags", id: false, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "milestone_id"
  end

  add_index "milestones_tags", ["milestone_id"], name: "index_milestones_tags_on_milestone_id", using: :btree
  add_index "milestones_tags", ["tag_id", "milestone_id"], name: "index_milestones_tags_on_tag_id_and_milestone_id", unique: true, using: :btree
  add_index "milestones_tags", ["tag_id"], name: "index_milestones_tags_on_tag_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "text"
    t.integer  "visibility"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "author_id"
    t.integer  "milestone_id"
  end

  add_index "notes", ["author_id"], name: "index_notes_on_author_id", using: :btree
  add_index "notes", ["milestone_id"], name: "index_notes_on_milestone_id", using: :btree

  create_table "participations", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "person_id"
    t.integer  "project_id"
  end

  add_index "participations", ["person_id"], name: "index_participations_on_person_id", using: :btree
  add_index "participations", ["project_id"], name: "index_participations_on_project_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cellphone"
    t.string   "phone"
    t.date     "birth_date"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "tech_role_id"
    t.boolean  "admin"
    t.string   "image_id"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree

  create_table "person_milestones", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "milestone_id"
    t.date     "completion_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "person_milestones", ["milestone_id"], name: "index_person_milestones_on_milestone_id", using: :btree
  add_index "person_milestones", ["person_id"], name: "index_person_milestones_on_person_id", using: :btree

  create_table "person_skills", force: :cascade do |t|
    t.date     "since_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "person_id"
    t.integer  "skill_id"
  end

  add_index "person_skills", ["person_id"], name: "index_person_skills_on_person_id", using: :btree
  add_index "person_skills", ["skill_id"], name: "index_person_skills_on_skill_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "client"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "status",     default: 0,    null: false
    t.boolean  "validity",   default: true, null: false
  end

  create_table "projects_technologies", force: :cascade do |t|
    t.integer "project_id"
    t.integer "technology_id"
  end

  add_index "projects_technologies", ["project_id"], name: "index_projects_technologies_on_project_id", using: :btree
  add_index "projects_technologies", ["technology_id"], name: "index_projects_technologies_on_technology_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "doc_id"
    t.string   "title"
    t.string   "url"
    t.integer  "milestone_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.integer  "type"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "tech_roles", force: :cascade do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "users", ["person_id"], name: "index_users_on_person_id", using: :btree

  add_foreign_key "mentorships", "people", column: "mentee_id"
  add_foreign_key "mentorships", "people", column: "mentor_id"
  add_foreign_key "milestones", "categories"
  add_foreign_key "milestones_tags", "milestones"
  add_foreign_key "milestones_tags", "tags"
  add_foreign_key "notes", "milestones"
  add_foreign_key "notes", "people", column: "author_id"
  add_foreign_key "participations", "people"
  add_foreign_key "participations", "projects"
  add_foreign_key "people", "tech_roles"
  add_foreign_key "person_skills", "people"
  add_foreign_key "person_skills", "skills"
end
