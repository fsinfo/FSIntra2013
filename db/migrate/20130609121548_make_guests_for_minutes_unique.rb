class MakeGuestsForMinutesUnique < ActiveRecord::Migration
  def change
  	add_index :minutes_guests, :name, :unique => true
  end
end
