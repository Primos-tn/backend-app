class CreateBusinessApiTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :business_api_tokens do |t|
      t.integer :account_id
      t.string :token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
