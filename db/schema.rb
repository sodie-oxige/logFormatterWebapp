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

ActiveRecord::Schema[7.2].define(version: 2024_08_31_072733) do
  create_table "appear_pcs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pc_id", null: false
    t.integer "log_id", null: false
    t.index ["log_id"], name: "index_appear_pcs_on_log_id"
    t.index ["pc_id"], name: "index_appear_pcs_on_pc_id"
  end

  create_table "logs", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pl_id", null: false
    t.index ["pl_id"], name: "index_logs_on_pl_id"
  end

  create_table "pcs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pl_id", null: false
    t.index ["pl_id"], name: "index_pcs_on_pl_id"
  end

  create_table "pls", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "session_id", null: false
    t.date "date", null: false
    t.integer "response", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_schedules_on_session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appear_pcs", "logs"
  add_foreign_key "appear_pcs", "pcs"
  add_foreign_key "logs", "pls"
  add_foreign_key "pcs", "pls"
  add_foreign_key "schedules", "sessions"
end
