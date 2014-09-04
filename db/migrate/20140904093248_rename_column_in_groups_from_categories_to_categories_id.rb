class RenameColumnInGroupsFromCategoriesToCategoriesId < ActiveRecord::Migration
  def self.up
    rename_column :groups , :categories , :categories_id
  end
  def self.down
    rename_column :groups , :categories_id , :categories
  end
end
