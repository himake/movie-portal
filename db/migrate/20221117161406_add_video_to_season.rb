class AddVideoToSeason < ActiveRecord::Migration[6.0]
  def change
    add_column :seasons, :video_key, :string
  end
end
