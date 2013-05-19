class AddMarkedAsPaidToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :marked_as_paid, :boolean
  end
end
