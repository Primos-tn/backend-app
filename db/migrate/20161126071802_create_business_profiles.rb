class CreateBusinessProfiles < ActiveRecord::Migration
  def change
    create_table :business_profiles do |t|
      t.integer :account_id
      t.integer :type, default: 1
      t.datetime :expires

      t.timestamps null: false
    end
  end
end
