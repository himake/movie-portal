class RemoveColumnFromSerial < ActiveRecord::Migration[6.0]
  def change
    remove_column :serials, :duration, :time
  end
end
