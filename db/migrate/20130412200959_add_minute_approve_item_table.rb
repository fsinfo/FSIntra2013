class AddMinuteApproveItemTable < ActiveRecord::Migration
  def change
  	create_table :minute_minute_approve_items do |t|
      t.integer :order
      t.references :minute
      
      t.timestamps
    end
  end
end
