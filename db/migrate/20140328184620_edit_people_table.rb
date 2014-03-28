class EditPeopleTable < ActiveRecord::Migration
  def change
    add_column :people, :parent_id, :int
  end
end
