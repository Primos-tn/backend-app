class CreateProfiles < ActiveRecord::Migration
  def change
    create_table  :profiles do |t|
	t.string  :telephone
	t.string  :first_name
	t.string  :profile_pic
	t.string  :last_name
	t.integer :postcode
	t.integer :account_id, index: true
	t.integer  :country_id
	t.date :birthdate
      t.timestamps null: false
    end
  end
end
