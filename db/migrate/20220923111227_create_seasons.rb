class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :name, null: false
      t.string :description
      t.string :image
      t.time :duration, null: false
      t.integer :number, null: false, limit: 2
      t.references :serial, null: false, foreign_key: true

      t.timestamps
    end
  end
end
