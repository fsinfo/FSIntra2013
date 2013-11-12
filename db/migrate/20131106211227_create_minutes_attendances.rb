class CreateMinutesAttendances < ActiveRecord::Migration
  def change
    create_table :minutes_attendances, id: false do |t|
      t.references :user, index: true
      t.references :minute, index: true
      t.string :type
    end
  end
end
