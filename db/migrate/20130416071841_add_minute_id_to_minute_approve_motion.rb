class AddMinuteIdToMinuteApproveMotion < ActiveRecord::Migration
  def change
  	add_column :minutes_minute_approve_motions, :minute_id, :integer
  end
end
