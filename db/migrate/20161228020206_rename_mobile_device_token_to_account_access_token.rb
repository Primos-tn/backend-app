class RenameMobileDeviceTokenToAccountAccessToken < ActiveRecord::Migration[5.0]
  def change
    rename_table :mobile_device_tokens, :account_access_tokens
  end
end
