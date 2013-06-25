class AddStatusToTab < ActiveRecord::Migration
  def change
    add_column :tabs, :status, :string, :default => 'running'
  end
end
