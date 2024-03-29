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

ActiveRecord::Schema.define(version: 20160402065707) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "githubs", force: :cascade do |t|
    t.string   "name"
    t.integer  "watchers"
    t.integer  "forks"
    t.string   "development_activity"
    t.date     "last_commit"
    t.date     "first_commit"
    t.integer  "contributors"
    t.integer  "issues"
    t.integer  "pull_requests"
    t.integer  "package_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "githubs", ["package_id"], name: "index_githubs_on_package_id"

  create_table "packages", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "pypi_url"
    t.string   "documentation_url"
    t.string   "source_code_url"
    t.string   "bug_tracker_url"
    t.integer  "category_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "packages", ["category_id"], name: "index_packages_on_category_id"

  create_table "pypis", force: :cascade do |t|
    t.string   "name"
    t.integer  "download_num"
    t.integer  "release_num"
    t.string   "current_version"
    t.date     "released_date"
    t.date     "first_release"
    t.string   "python_version"
    t.integer  "package_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pypis", ["package_id"], name: "index_pypis_on_package_id"

end
