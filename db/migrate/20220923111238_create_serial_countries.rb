class CreateSerialCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :serial_countries do |t|
      t.references :serial, null: false, foreign_key: true
      t.references :actor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
