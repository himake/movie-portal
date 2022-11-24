class RemoveColumnFromSeries < ActiveRecord::Migration[6.0]
  def change
    remove_column :series, :duration, :time
  end
end
