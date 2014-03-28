class DeleteFamilyTitlesRelationships < ActiveRecord::Migration
  def change
    drop_table :family_titles
    drop_table :relationships
  end
end
