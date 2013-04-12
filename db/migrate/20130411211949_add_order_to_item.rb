class AddOrderToItem < ActiveRecord::Migration
  def change
  	add_column :minutes_items, :order, :integer
  end
end
