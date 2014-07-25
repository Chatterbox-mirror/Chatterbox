class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.string :status, default: 'open'
      t.integer :group_id
      t.integer :owner_id
      t.timestamps
    end
    add_index :topics, :group_id
    add_index :topics, :owner_id
  end
end
