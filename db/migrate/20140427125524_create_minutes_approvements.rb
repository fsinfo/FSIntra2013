class CreateMinutesApprovements < ActiveRecord::Migration
  def change
    create_table :minutes_approvements do |t|
      t.references :minute, index: true
      t.references :approved_minute, index: true
      t.integer :pro
      t.integer :con
      t.integer :abs
      t.boolean :apparent_majority
      t.boolean :approved
      
      t.timestamps
    end
  end
end
