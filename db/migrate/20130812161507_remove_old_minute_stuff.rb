class RemoveOldMinuteStuff < ActiveRecord::Migration
  def up
  	drop_table :invitees if ActiveRecord::Base.connection.table_exists? :invitees
  	drop_table :minutes if ActiveRecord::Base.connection.table_exists? :minutes
  	drop_table :minutes_attendances if ActiveRecord::Base.connection.table_exists? :minutes_attendances
  	drop_table :minutes_guests if ActiveRecord::Base.connection.table_exists? :minutes_guests
  	drop_table :minutes_items if ActiveRecord::Base.connection.table_exists? :minutes_items
  	drop_table :minutes_minute_approve_items if ActiveRecord::Base.connection.table_exists? :minutes_minute_approve_items
  	drop_table :minutes_minute_approve_motions if ActiveRecord::Base.connection.table_exists? :minutes_minute_approve_motions
  	drop_table :minutes_minutes_guests if ActiveRecord::Base.connection.table_exists? :minutes_minutes_guests
  	drop_table :minutes_motions if ActiveRecord::Base.connection.table_exists? :minutes_motions
  end

  def down
  	puts "You're fucked."
  end
end
