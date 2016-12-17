class CreateAccessTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :access_tokens do |t|
      t.integer :account
      t.string :value
      t.datetime :expires_at

      t.timestamps
    end
  end
end
