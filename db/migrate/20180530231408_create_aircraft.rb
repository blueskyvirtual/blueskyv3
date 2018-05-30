# frozen_string_literal: true

class CreateAircraft < ActiveRecord::Migration[5.2]
  def change
    create_table :aircraft, id: :uuid do |t|
      t.uuid    :fleet_id,     null: false
      t.string  :registration, null: false, unique: true
      t.uuid    :airport_id
      t.boolean :active,       default: true
    end

    add_foreign_key :aircraft, :fleets
    add_foreign_key :aircraft, :airports
    add_index :aircraft, :registration
  end
end
