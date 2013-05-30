class AddApprovedFlagForMotions < ActiveRecord::Migration
  def change
    add_column :minutes_minute_approve_motions, :approved, :boolean, :default => false
    add_column :minutes_motions, :approved, :boolean, :default => false
  end
end
