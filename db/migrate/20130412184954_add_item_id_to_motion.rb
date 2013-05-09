class AddItemIdToMotion < ActiveRecord::Migration
  def change
  	add_column :minutes_motions, :item_id, :integer
  end
end
