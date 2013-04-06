class CreateMinutesItems < ActiveRecord::Migration
  def change
    create_table :minutes_items do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
