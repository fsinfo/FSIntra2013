class AddQuorumFlagToMinutes < ActiveRecord::Migration
  def change
  	add_column :minutes, :has_quorum, :boolean
  end
end
