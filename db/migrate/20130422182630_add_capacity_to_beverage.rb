class AddCapacityToBeverage < ActiveRecord::Migration
  def change
    add_column :beverages, :capacity, :decimal, :precision => 8, :scale => 2
  end
end
