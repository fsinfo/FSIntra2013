class CreateMinutesAttendances < ActiveRecord::Migration
  def change
    create_table :minutes_attendances, :id => false do |t|
    	t.string :absent
    	t.references :user
    	t.references :minute
    end
  end
end
