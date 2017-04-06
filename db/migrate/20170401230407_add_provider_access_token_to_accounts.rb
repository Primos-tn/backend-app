class AddProviderAccessTokenToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :provider_access_token, :string
  end
end
