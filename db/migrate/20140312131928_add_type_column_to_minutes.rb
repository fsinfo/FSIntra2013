class AddTypeColumnToMinutes < ActiveRecord::Migration
  def change
  	add_column :minutes_minutes, :type, :string
  end
end
