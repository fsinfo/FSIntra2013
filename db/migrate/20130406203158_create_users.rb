class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :loginname
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :zip
      t.string :city
      t.string :email
      t.string :phone
      t.date :birthday
      t.text :misc
      t.string :remember_token

      t.timestamps
    end
  end
end
