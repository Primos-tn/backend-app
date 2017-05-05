class CreateMessengerAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :messenger_accounts do |t|
      t.integer :user_id
      t.integer :last_connexion
      t.string :last_name
      t.string :first_name
      t.string :cover
      t.string :locale
      t.json :location

      t.timestamps
    end
  end
end
