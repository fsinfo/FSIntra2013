class RenameMinutesItemIdToItemId < ActiveRecord::Migration
  def change
  	rename_column(:minutes_motions, :minutes_item_id, :item_id)
  end
end
