# frozen_string_literal: true

class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles, id: :uuid do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end
  end
end
