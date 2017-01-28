class RemovePushTokenValueFromAccessTokens < ActiveRecord::Migration[5.0]
  def change
    remove_column :account_access_tokens, :push_token_value
  end
end
