# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 2018_05_29_194700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "airports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "icao", limit: 4, null: false
    t.string "iata", limit: 3
    t.string "name", null: false
    t.string "city", null: false
    t.decimal "latitude", precision: 17, scale: 14, null: false
    t.decimal "longitude", precision: 17, scale: 14, null: false
    t.integer "elevation", limit: 2, null: false
    t.uuid "region_id"
    t.index ["icao"], name: "index_airports_on_icao"
  end

  create_table "countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code", limit: 3, null: false
    t.string "name", null: false
    t.index ["code"], name: "index_countries_on_code"
  end

  create_table "regions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code", limit: 4, null: false
    t.string "name", null: false
    t.uuid "country_id", null: false
    t.index ["code"], name: "index_regions_on_code"
  end

  add_foreign_key "airports", "regions"
  add_foreign_key "regions", "countries"
end
