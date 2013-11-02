class CreateMinutesMinutes < ActiveRecord::Migration
  def change
    create_table :minutes_minutes do |t|
      t.date :date
      t.references :keeper_of_the_minutes, index: true
      t.references :chairperson, index: true
      t.date :released_date
      t.boolean :has_quorum

      t.timestamps
    end
  end
end
