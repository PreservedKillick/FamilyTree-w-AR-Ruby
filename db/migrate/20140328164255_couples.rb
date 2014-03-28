class Couples < ActiveRecord::Migration
  def change
    create_table :couples do |t|
    t.column :person1_id, :integer
    t.column :person2_id, :integer

    t.timestamps
    end
  end
end
