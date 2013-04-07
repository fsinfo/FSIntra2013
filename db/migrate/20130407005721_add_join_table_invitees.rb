class AddJoinTableInvitees < ActiveRecord::Migration
  def change
    create_table :invitees, id: false do |t|
      t.integer :minute_id
      t.integer :user_id
      t.boolean :absent
    end
  end
end
