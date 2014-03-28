class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.column :person_id, :int
      t.column :spouse_id, :int
      t.column :father_id, :int
      t.column :mother_id, :int
      t.column :daughter_id, :int
      t.column :son_id, :int
      t.column :sister_id, :int
      t.column :brother_id, :int
      t.column :grandparent_id, :int
      t.timestamps
    end
  end
end
