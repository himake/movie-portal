class AddColumnToSerial < ActiveRecord::Migration[6.0]
  def change
    add_column :serials, :image, :string
  end
end
