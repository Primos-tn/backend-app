class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
	  t.string :email
	  t.string :body
	  t.string :type
      t.timestamps null: false
    end
  end
end
