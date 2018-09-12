class CreateKinesiologists < ActiveRecord::Migration
  def change
    create_table :kinesiologists do |t|
      t.integer :id_centro
      t.string :nombre
      t.float :hh_mensuales

      t.timestamps
    end
  end
end
