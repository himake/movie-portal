class CreateSeasonsActors < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons_actors do |t|
      t.references :season, null: false, foreign_key: true
      t.references :actor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
