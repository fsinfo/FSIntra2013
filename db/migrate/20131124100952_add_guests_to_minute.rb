class AddGuestsToMinute < ActiveRecord::Migration
  def change
  	add_column :minutes_minutes, :guests, :text
  end
end
