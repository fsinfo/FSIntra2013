class AddCapacityToBeverageTab < ActiveRecord::Migration
  def change
    add_column :beverage_tabs, :capacity, :decimal, :precision => 8, :scale => 2
  end
end
