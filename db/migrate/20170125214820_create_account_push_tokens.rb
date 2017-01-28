class CreateAccountPushTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :account_push_tokens do |t|
      t.integer :account_id
      t.string :value
      t.string :platform
      t.json :details

      t.timestamps
    end
  end
end
