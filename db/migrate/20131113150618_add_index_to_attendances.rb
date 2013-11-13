class AddIndexToAttendances < ActiveRecord::Migration
  def change
  	add_index :minutes_attendances, [:user_id, :minute_id]
  end
end
