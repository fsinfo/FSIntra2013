class AddIndexToAttendances < ActiveRecord::Migration
  def change
  	add_column :minutes_attendances, :id, :primary_key
  end
end
