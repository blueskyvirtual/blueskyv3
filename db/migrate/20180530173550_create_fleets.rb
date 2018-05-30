# frozen_string_literal: true

class CreateFleets < ActiveRecord::Migration[5.2]
  def change
    create_table :fleets, id: :uuid do |t|
      t.uuid    :airline_id, null: false
      t.string  :icao,  limit: 4, null: false
      t.string  :name,  null: false
      t.string  :cat,   limit: 1, null: false
      t.string  :equip, limit: 1, null: false
      t.integer :pax,   limit: 2, null: false
      t.integer :oew,   limit: 3, null: false
      t.integer :mzfw,  limit: 3, null: false
      t.integer :mtow,  limit: 3, null: false
      t.integer :mlw,   limit: 3, null: false
      t.integer :mfc,   limit: 3, null: false
      t.decimal :ff,    precision: 2, scale: 0, default: 0, null: false
      t.decimal :ci,    precision: 3, scale: 0
    end

    add_foreign_key :fleets, :airlines
    add_index :fleets, :icao
  end
end
