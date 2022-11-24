class AddColumnToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :body, :string, limit: 250
    add_column :comments, :time, :time
  end
end
