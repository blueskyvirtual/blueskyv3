# frozen_string_literal: true

class CreateAirports < ActiveRecord::Migration[5.2]
  def change
    create_table :airports, id: :uuid do |t|
      t.string  :icao, limit: 4, null: false, unique: true
      t.string  :iata, limit: 3
      t.string  :name, null: false
      t.string  :city, null: false
      t.decimal :latitude, precision: 17, scale: 14, null: false
      t.decimal :longitude, precision: 17, scale: 14, null: false
      t.integer :elevation, limit: 2, null: false
      t.uuid    :region_id
    end

    add_index :airports, :icao
    add_foreign_key :airports, :regions
  end
end
