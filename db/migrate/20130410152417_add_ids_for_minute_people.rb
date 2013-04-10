class AddIdsForMinutePeople < ActiveRecord::Migration
  def change
  	add_column :minutes, :keeper_of_the_minutes_id, :integer
		add_column :minutes, :chairperson_id, :integer
  end
end
