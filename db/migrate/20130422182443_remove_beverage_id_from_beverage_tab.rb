class RemoveBeverageIdFromBeverageTab < ActiveRecord::Migration
  def change
    remove_column :beverage_tabs, :beverage_id, :integer
  end
end
