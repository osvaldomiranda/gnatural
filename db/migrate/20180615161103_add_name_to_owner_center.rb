class AddNameToOwnerCenter < ActiveRecord::Migration
  def change
    add_column :owner_centers, :name_center, :string
  end
end
