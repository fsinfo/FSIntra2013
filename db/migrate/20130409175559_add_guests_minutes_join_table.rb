class AddGuestsMinutesJoinTable < ActiveRecord::Migration
  def change
  	create_table :minutes_minutes_guests, id: false do |t|
      t.integer :guest_id
      t.integer :minute_id
    end
  end
end
