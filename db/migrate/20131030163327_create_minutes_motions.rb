class CreateMinutesMotions < ActiveRecord::Migration
  def change
    create_table :minutes_motions do |t|
      t.integer :order
      t.references :mover, index: true
      t.integer :pro
      t.integer :con
      t.integer :abs
      t.text :rationale
      t.integer :amount
      t.references :minutes_item, index: true
      t.boolean :approved

      t.timestamps
    end
  end
end
