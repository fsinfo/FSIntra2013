class AddMinuteMissingTable < ActiveRecord::Migration
  def change
  	change_column :invitees, :absent, :string
  end
end
