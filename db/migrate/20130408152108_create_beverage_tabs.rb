class CreateBeverageTabs < ActiveRecord::Migration
  def change
    create_table :beverage_tabs do |t|
      t.integer :beverage_id
      t.integer :tab_id
      t.integer :count
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
