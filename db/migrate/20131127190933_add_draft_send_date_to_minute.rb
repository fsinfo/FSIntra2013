class AddDraftSendDateToMinute < ActiveRecord::Migration
  def change
  	add_column :minutes_minutes, :draft_sent_date, :date
  end
end
