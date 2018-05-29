# frozen_string_literal: true

class CreateRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :regions, id: :uuid do |t|
      t.string :code, limit: 4, null: false
      t.string :name, null: false
      t.uuid   :country_id, null: false
    end

    add_index :regions, :code
    add_foreign_key :regions, :countries
  end
end
