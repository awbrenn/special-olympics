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

ActiveRecord::Schema.define(version: 20140308170244) do

  create_table "athletes", force: true do |t|
    t.integer  "teacher_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "gender"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "athletes", ["teacher_id"], name: "index_athletes_on_teacher_id"

  create_table "athletes_heats", id: false, force: true do |t|
    t.integer "athlete_id"
    t.integer "heat_id"
  end

  add_index "athletes_heats", ["athlete_id", "heat_id"], name: "index_athletes_heats_on_athlete_id_and_heat_id"
  add_index "athletes_heats", ["heat_id"], name: "index_athletes_heats_on_heat_id"

  create_table "events", force: true do |t|
    t.string   "event_code"
    t.string   "event_name"
    t.string   "score_unit"
    t.integer  "min_score"
    t.integer  "max_score"
    t.integer  "sort_seq"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "group_code"
    t.string   "school_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "heat_sheet_generators", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "heats", force: true do |t|
    t.integer  "event_id"
    t.string   "gender"
    t.integer  "min_age"
    t.integer  "max_age"
    t.string   "time"
    t.integer  "num_heats"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "heats", ["event_id"], name: "index_heats_on_event_id"

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["group_id"], name: "index_teachers_on_group_id"

end
