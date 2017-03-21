class ChangeExpiresTypeInAccountsAccessToken < ActiveRecord::Migration[5.0]
  def change
    remove_column :account_access_tokens, :expires
    add_column :account_access_tokens, :expires, :datetime
  end
end
