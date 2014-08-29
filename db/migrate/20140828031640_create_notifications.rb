class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :type
      t.integer :user_id
      t.integer :group_id
      t.integer :actor_id
      t.text :content
      t.timestamps
    end
    add_index :notifications, [:user_id, :group_id, :type]
  end
end
