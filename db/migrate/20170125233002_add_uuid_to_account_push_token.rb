class AddUuidToAccountPushToken < ActiveRecord::Migration[5.0]
  def change
    add_column :account_push_tokens, :uuid, :string
  end
end
