# frozen_string_literal: true

class CreateRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :ranks, id: :uuid do |t|
      t.string  :name,  null: false,  unique: true
      t.decimal :hours, precision: 6, scale: 1, default: 0
      t.decimal :pay_rate, precision: 8, scale: 2, default: 0
      t.boolean :auto_approve_acars, default: true
      t.boolean :auto_approve_manual, default: false
      t.boolean :auto_promote, default: true

      t.timestamps
    end
  end
end
