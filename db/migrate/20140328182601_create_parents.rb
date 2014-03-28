class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.column :parent1_id, :integer
      t.column :parent2_id, :integer

      t.timestamps
    end
  end
end
