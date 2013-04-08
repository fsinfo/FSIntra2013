class CreateUserTabsJoinTable < ActiveRecord::Migration
  def change
		create_table :user_tabs, :id => false do |t|
			t.integer :user_id
			t.integer :tab_id
		end
		add_index :user_tabs, [:user_id, :tab_id], :unique => true
  end
end
