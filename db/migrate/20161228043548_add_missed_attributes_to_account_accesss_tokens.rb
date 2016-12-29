class AddMissedAttributesToAccountAccesssTokens < ActiveRecord::Migration[5.0]
  def change
    add_column :account_access_tokens, :push_token_value, :string
    add_column :account_access_tokens, :token_value, :string
  end
end
