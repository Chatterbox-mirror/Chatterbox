class AddIconToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :icon, :string
  end
end
