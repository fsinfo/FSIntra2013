class CreateMinutes < ActiveRecord::Migration
  def change
    create_table :minutes do |t|
      t.datetime :date
      t.string :status, :default => 'draft'

      t.timestamps
    end
  end
end
