class AddNameToBeverageTab < ActiveRecord::Migration
  def change
    add_column :beverage_tabs, :name, :string
  end
end
