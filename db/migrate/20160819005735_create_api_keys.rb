class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.integer :account_id
      t.string :value
      t.datetime :valide_to

      t.timestamps null: false
    end
  end
end
