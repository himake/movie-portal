class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, limit: 50
    add_column :users, :surname, :string, limit: 50
  end
end
