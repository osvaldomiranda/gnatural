class AddRutToUser < ActiveRecord::Migration
  def change
    add_column :users, :rut, :string
    add_column :users, :name, :string
  end
end
