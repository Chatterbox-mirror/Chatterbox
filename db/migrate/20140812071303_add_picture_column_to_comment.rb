class AddPictureColumnToComment < ActiveRecord::Migration
  def change
    add_column :comments, :type, :string
    add_column :comments, :picture, :string
  end
end
