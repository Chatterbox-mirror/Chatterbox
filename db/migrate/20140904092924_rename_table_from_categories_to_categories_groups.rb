class RenameTableFromCategoriesToCategoriesGroups < ActiveRecord::Migration
  def self.up
    rename_table "categories" , "categories_groups"
  end
  def self.down
    rename_table "categories_groups" , "categories"
  end
end
