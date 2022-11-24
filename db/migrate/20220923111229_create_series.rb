class CreateSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :series do |t|
      t.string :name, null: false
      t.string :description
      t.string :image
      t.time :duration, null: false
      t.integer :number, null: false
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
