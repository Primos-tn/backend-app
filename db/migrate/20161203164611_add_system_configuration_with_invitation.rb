class AddSystemConfigurationWithInvitation < ActiveRecord::Migration
  def change
    add_column :system_configurations, :with_invitation, :boolean, default: true
  end
end
