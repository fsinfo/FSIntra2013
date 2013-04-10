class AddPaidColumnToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :paid, :boolean
  end
end
