class ChangeMessengerUserIdType < ActiveRecord::Migration[5.0]
  def up
    change_column :messenger_accounts, :user_id, :string
  end

  def down
    change_column :messenger_accounts, :user_id, :string
  end
end
