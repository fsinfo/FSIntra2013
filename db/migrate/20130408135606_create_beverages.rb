class CreateBeverages < ActiveRecord::Migration
  def change
    create_table :beverages do |t|
      t.string :name
      t.text :description
      t.boolean :available
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
