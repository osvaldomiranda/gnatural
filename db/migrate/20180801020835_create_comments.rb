class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :center_id
      t.text :coment

      t.timestamps
    end
  end
end
