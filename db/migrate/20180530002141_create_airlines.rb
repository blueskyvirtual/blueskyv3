class CreateAirlines < ActiveRecord::Migration[5.2]
  def change
    create_table :airlines, id: :uuid do |t|
      t.string :icao, null: false, unique: true, length: 3
      t.string :iata, length: 2
      t.string :name, null: false, unique: true
      t.timestamps
    end
  end
end
