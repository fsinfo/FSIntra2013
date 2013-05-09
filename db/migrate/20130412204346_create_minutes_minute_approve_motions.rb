class CreateMinutesMinuteApproveMotions < ActiveRecord::Migration
  def change
    create_table :minutes_minute_approve_motions do |t|
    	t.integer :pro
    	t.integer :abs
    	t.integer :con
    	t.references :minute_approve_item

      t.timestamps
    end
  end
end
