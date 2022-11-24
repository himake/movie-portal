class RemoveColumnFromSeason < ActiveRecord::Migration[6.0]
  def change
    remove_column :seasons, :duration, :time
  end
end
