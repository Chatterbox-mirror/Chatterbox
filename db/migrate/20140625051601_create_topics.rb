class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.integer :group_id

      t.timestamps
    end
    add_index :topics, :group_id
  end
end
