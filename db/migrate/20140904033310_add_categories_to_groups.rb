class AddCategoriesToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups , :categories , :string 
  end
  def self.down
    remove_column :groups , :categories
  end
end
