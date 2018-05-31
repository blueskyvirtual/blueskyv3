# frozen_string_literal: true

class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights, id: :uuid do |t|
      t.uuid    :airline_id,     null: false
      t.integer :number,         null: false
      t.uuid    :origin_id,      null: false
      t.uuid    :destination_id, null: false
      t.time    :depart_time,    null: false
      t.time    :arrive_time,    null: false
      t.string  :days,           null: false, default: "1234567"
      t.uuid    :fleet_id,       null: false
      t.decimal :distance,       null: false, precision: 6, scale: 1
    end

    add_foreign_key :flights, :airlines
    add_foreign_key :flights, :fleets
    add_foreign_key :flights, :airports, column: :origin_id
    add_foreign_key :flights, :airports, column: :destination_id

    add_index :flights, :number
  end
end
