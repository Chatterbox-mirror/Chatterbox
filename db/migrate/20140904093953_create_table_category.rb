class CreateTableCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string   :name
    end

		change_table :groups do |t|
			t.integer  :category_id
		end
  end
end
