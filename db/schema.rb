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

ActiveRecord::Schema.define(version: 20170623213630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "distributors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "edition_formats", force: :cascade do |t|
    t.integer "number_of_discs", default: 1
    t.bigint "edition_id"
    t.bigint "format_id"
    t.index ["edition_id"], name: "index_edition_formats_on_edition_id"
    t.index ["format_id"], name: "index_edition_formats_on_format_id"
  end

  create_table "editions", force: :cascade do |t|
    t.string "name"
    t.bigint "distributor_id"
    t.date "release_date"
    t.string "country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["distributor_id"], name: "index_editions_on_distributor_id"
  end

  create_table "formats", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packagings", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.bigint "format_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format_id"], name: "index_regions_on_format_id"
  end

  add_foreign_key "edition_formats", "editions"
  add_foreign_key "edition_formats", "formats"
  add_foreign_key "editions", "distributors"
  add_foreign_key "regions", "formats"
end
