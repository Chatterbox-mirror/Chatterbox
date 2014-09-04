class CreateTableCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer     :groupid
      t.string      :name
      t.integer     :cateid
    end
  end
  def self.down
    remove_table :categories
  end
end
