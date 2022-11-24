class AddVideoKeyToMovie < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :video_key, :string
  end
end
