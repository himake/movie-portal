class AddVideoToSerial < ActiveRecord::Migration[6.0]
  def change
    add_column :serials, :video_key, :string
  end
end
