class AddAttachmentImageToBeverages < ActiveRecord::Migration
  def self.up
    change_table :beverages do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :beverages, :image
  end
end
