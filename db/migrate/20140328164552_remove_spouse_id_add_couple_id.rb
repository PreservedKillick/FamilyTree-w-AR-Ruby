class RemoveSpouseIdAddCoupleId < ActiveRecord::Migration
  def change
    remove_column :people, :spouse_id, :integer
    add_column :people, :couple_id, :integer
  end
end
