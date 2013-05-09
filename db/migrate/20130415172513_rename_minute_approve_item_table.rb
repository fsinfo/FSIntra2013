class RenameMinuteApproveItemTable < ActiveRecord::Migration
  def change
  	rename_table :minute_minute_approve_items, :minutes_minute_approve_items
  end
end
