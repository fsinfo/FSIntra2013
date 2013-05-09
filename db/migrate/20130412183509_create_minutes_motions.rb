class CreateMinutesMotions < ActiveRecord::Migration
  def change
    create_table :minutes_motions do |t|
      t.text :rationale
      t.references :mover, index: true
      t.decimal :amount
      t.integer :pro
      t.integer :abs
      t.integer :con

      t.timestamps
    end
  end
end
