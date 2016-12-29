class RenameColumnUserOfAccessTokenToAccountId < ActiveRecord::Migration[5.0]
  def change
    rename_column  :account_access_tokens, :user, :account_id
  end
end
