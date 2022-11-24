class CreateWishes < ActiveRecord::Migration[6.0]
  def change
    create_table :wishes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wishable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
