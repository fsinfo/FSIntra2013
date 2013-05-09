class AddOnBeverageListToPeople < ActiveRecord::Migration
  def change
    add_column :people, :on_beverage_list, :boolean, :default => false
  end
end
