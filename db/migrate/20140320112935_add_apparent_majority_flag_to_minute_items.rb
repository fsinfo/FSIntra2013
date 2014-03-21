class AddApparentMajorityFlagToMinuteItems < ActiveRecord::Migration
  def change
    add_column :minutes_motions, :apparent_majority, :boolean
  end
end
