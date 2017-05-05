class CreateMessengerAccountBrandFollowers < ActiveRecord::Migration[5.0]
  def change
    create_table :messenger_account_brand_followers do |t|
      t.integer :messenger_account_id
      t.integer :brand_id

      t.timestamps
    end
  end
end
