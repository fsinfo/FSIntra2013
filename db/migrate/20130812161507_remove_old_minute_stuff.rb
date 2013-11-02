class RemoveOldMinuteStuff < ActiveRecord::Migration
  def up
  	drop_table :invitees
  	drop_table :minutes
  	drop_table :minutes_attendances
  	drop_table :minutes_guests
  	drop_table :minutes_items
  	drop_table :minutes_minute_approve_items
  	drop_table :minutes_minute_approve_motions
  	drop_table :minutes_minutes_guests
  	drop_table :minutes_motions
  end

  def down
  	puts "You're fucked."
  end
end
