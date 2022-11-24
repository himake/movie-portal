class RemoveClipFromMovie < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :clip, :string
  end
end
