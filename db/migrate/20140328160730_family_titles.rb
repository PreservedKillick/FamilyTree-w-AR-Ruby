class FamilyTitles < ActiveRecord::Migration
  def change
    create_table :family_titles do |t|
      t.column :spouse, :string
      t.column :father, :string
      t.column :mother, :string
      t.column :daughter, :string
      t.column :son, :string
      t.column :sister, :string
      t.column :brother, :string
      t.column :grandparent, :string
      t.timestamps
    end
  end
end
