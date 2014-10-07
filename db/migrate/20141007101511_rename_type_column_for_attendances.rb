class RenameTypeColumnForAttendances < ActiveRecord::Migration
  def change
    rename_column :minutes_attendances, :type, :a_type
  end
end
