class AddUsernameToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :username, :string
    add_index :accounts, :username, unique: true
  end
end
