class CreateDirectors < ActiveRecord::Migration[6.0]
  def change
    create_table :directors do |t|
      t.string :full_name, null: false
      t.string :biography
      t.string :date_of_birth
      t.string :image
      t.string :place_of_birth

      t.timestamps
    end
  end
end
