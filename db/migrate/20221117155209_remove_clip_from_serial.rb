class RemoveClipFromSerial < ActiveRecord::Migration[6.0]
  def change
    remove_column :serials, :clip, :string
  end
end
