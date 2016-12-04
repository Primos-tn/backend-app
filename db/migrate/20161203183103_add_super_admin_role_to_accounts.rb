class AddSuperAdminRoleToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :is_super_admin, :boolean, default: false
  end
end
