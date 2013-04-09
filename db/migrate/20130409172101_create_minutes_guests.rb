class CreateMinutesGuests < ActiveRecord::Migration
  def change
    create_table :minutes_guests do |t|
      t.string :name

      t.timestamps
    end
  end
end
