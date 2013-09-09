class AddDefaultCountToBeverageTabs < ActiveRecord::Migration
  def change
    change_column(:beverage_tabs, :count, :integer, :default => 0)
  end
end
