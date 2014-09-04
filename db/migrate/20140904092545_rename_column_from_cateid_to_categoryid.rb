class RenameColumnFromCateidToCategoryid < ActiveRecord::Migration
  def self.up
    rename_column :categories , :cateid , :category_id
    rename_column :categories , :groupid , :group_id
    remove_column :categories , :name
  end
  def self.down
    rename_column :categories , :category_id , :cateid
    rename_column :categories , :group_id , :groupid
    add_column :categories , :name , :string
  end
end
