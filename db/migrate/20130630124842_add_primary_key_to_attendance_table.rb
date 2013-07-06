class AddPrimaryKeyToAttendanceTable < ActiveRecord::Migration
  def change
  	add_column :minutes_attendances, :id, :primary_key 
  	add_index :minutes_attendances, :id
  end
end
