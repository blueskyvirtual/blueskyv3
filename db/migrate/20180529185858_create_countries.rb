# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries, id: :uuid do |t|
      t.string "code", limit: 3, unique: true, null: false
      t.string "name", null: false
    end

    add_index :countries, :code
  end
end
