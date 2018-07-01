class AddIdToOwnerCenter < ActiveRecord::Migration
  def change
    add_column :owner_centers, :id_centro, :integer
  end
end
