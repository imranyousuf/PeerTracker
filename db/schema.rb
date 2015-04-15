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

ActiveRecord::Schema.define(version: 20150415191031) do

  create_table "admins", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.integer  "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.string   "assignment_name"
    t.integer  "course_id"
    t.datetime "deadline"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string  "course_name"
    t.integer "professor_id"
  end

  create_table "courses_students", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "student_id"
  end

  add_index "courses_students", ["course_id"], name: "index_courses_students_on_course_id"
  add_index "courses_students", ["student_id"], name: "index_courses_students_on_student_id"

  create_table "credentials", force: :cascade do |t|
    t.integer "uid"
    t.integer "course_id"
  end

  create_table "feedback_givens", force: :cascade do |t|
    t.text     "comments"
    t.integer  "rating"
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "feedback_receiveds", force: :cascade do |t|
    t.text     "comments"
    t.integer  "rating"
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "instructors", force: :cascade do |t|
    t.string   "name"
    t.integer  "sid"
    t.string   "email"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "models", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "models", ["email"], name: "index_models_on_email", unique: true
  add_index "models", ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.integer  "sid"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students_teams", id: false, force: :cascade do |t|
    t.integer "student_id"
    t.integer "team_id"
  end

  add_index "students_teams", ["student_id"], name: "index_students_teams_on_student_id"
  add_index "students_teams", ["team_id"], name: "index_students_teams_on_team_id"

  create_table "teams", force: :cascade do |t|
    t.string  "name"
    t.integer "course_id"
    t.integer "instructor_id"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
