class AddCachedTagListToPeople < ActiveRecord::Migration
  def change
    add_column :people, :cached_tag_list, :string
  end
end
