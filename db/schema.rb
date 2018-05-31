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

ActiveRecord::Schema.define(version: 2018_05_31_131100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "aircraft", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "fleet_id", null: false
    t.string "registration", null: false
    t.uuid "airport_id"
    t.boolean "active", default: true
    t.index ["registration"], name: "index_aircraft_on_registration"
  end

  create_table "airlines", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "icao", null: false
    t.string "iata"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "fleets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "airline_id", null: false
    t.string "icao", limit: 4, null: false
    t.string "name", null: false
    t.string "cat", limit: 1, null: false
    t.string "equip", limit: 1, null: false
    t.integer "pax", limit: 2, null: false
    t.integer "oew", null: false
    t.integer "mzfw", null: false
    t.integer "mtow", null: false
    t.integer "mlw", null: false
    t.integer "mfc", null: false
    t.decimal "ff", precision: 2, default: "0", null: false
    t.decimal "ci", precision: 3
    t.index ["icao"], name: "index_fleets_on_icao"
  end

  create_table "flights", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "airline_id", null: false
    t.integer "number", null: false
    t.uuid "origin_id", null: false
    t.uuid "destination_id", null: false
    t.time "depart_time", null: false
    t.time "arrive_time", null: false
    t.string "days", default: "1234567", null: false
    t.uuid "fleet_id", null: false
    t.decimal "distance", precision: 6, scale: 1, null: false
    t.index ["number"], name: "index_flights_on_number"
  end

  create_table "ranks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.decimal "hours", precision: 6, scale: 1, default: "0.0"
    t.decimal "pay_rate", precision: 8, scale: 2, default: "0.0"
    t.boolean "auto_approve_acars", default: true
    t.boolean "auto_approve_manual", default: false
    t.boolean "auto_promote", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code", limit: 4, null: false
    t.string "name", null: false
    t.uuid "country_id", null: false
    t.index ["code"], name: "index_regions_on_code"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "aircraft", "airports"
  add_foreign_key "aircraft", "fleets"
  add_foreign_key "airports", "regions"
  add_foreign_key "fleets", "airlines"
  add_foreign_key "flights", "airlines"
  add_foreign_key "flights", "airports", column: "destination_id"
  add_foreign_key "flights", "airports", column: "origin_id"
  add_foreign_key "flights", "fleets"
  add_foreign_key "regions", "countries"
end
