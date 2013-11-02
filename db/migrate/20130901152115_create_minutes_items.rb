class CreateMinutesItems < ActiveRecord::Migration
  def change
    create_table :minutes_items do |t|
      t.date :date
      t.string :title
      t.text :content
      t.integer :order
      t.references :minute, index: true

      t.timestamps
    end
  end
end
