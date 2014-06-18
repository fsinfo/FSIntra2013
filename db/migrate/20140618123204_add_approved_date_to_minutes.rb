class AddApprovedDateToMinutes < ActiveRecord::Migration
  def up
    add_column :minutes_minutes, :approved_date, :date
    Minutes::Minute.all.each do |m|
      m.approvements.each do |a|
        am = a.approved_minute
        am.approved_date = m.date
        am.save
      end
    end
  end

  def down
    remove_column :minutes_minutes, :approved_date, :date
  end
end
