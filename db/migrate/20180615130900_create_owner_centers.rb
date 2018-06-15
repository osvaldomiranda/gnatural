class CreateOwnerCenters < ActiveRecord::Migration
  def change
    create_table :owner_centers do |t|
      t.references :user, index: true
      t.string :rut_centro

      t.timestamps
    end
  end
end
