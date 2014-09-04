class ChangeGroupColumnCategoriesAttrFromStringToInteger < ActiveRecord::Migration
  def self.up
    change_column :groups , :categories , :integer
  end
  def self.down
    change_column :groups , :categories , :string
  end
end
