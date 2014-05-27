class AddExternalPricesToBeverages < ActiveRecord::Migration
  def change
  	add_column :beverages, :external_price, :decimal, :precision => 8, :scale => 2
  end
end
