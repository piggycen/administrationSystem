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

ActiveRecord::Schema.define(version: 20160108064156) do

  create_table "clas", force: true do |t|
    t.string   "clno"
    t.string   "clname"
    t.integer  "major_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clas", ["clno"], name: "index_clas_on_clno"

  create_table "departments", force: true do |t|
    t.string   "dno"
    t.string   "dname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["dno"], name: "index_departments_on_dno"

  create_table "majors", force: true do |t|
    t.string   "mno"
    t.string   "mname"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "majors", ["mno"], name: "index_majors_on_mno"

  create_table "students", force: true do |t|
    t.string   "sno"
    t.string   "sname"
    t.string   "ssex"
    t.date     "sbirthday"
    t.string   "splace"
    t.string   "spassport"
    t.string   "sgetin"
    t.string   "schooling"
    t.string   "snation"
    t.integer  "cla_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["sno"], name: "index_students_on_sno"

  create_table "teachers", force: true do |t|
    t.string   "tno"
    t.string   "tname"
    t.string   "tsex"
    t.date     "tbirthday"
    t.string   "tfunction"
    t.string   "tplace"
    t.string   "tnation"
    t.string   "tpassport"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["tno"], name: "index_teachers_on_tno"

  create_table "users", force: true do |t|
    t.string   "no"
    t.string   "pwd"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["no"], name: "index_users_on_no"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
