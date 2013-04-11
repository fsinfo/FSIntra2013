class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :zip
      t.string :city
      t.string :email
      t.string :phone
      t.date :birthday
      t.text :misc
      t.string :loginname
      t.string :remember_token
      t.string :type

      t.timestamps
    end
  end
end
