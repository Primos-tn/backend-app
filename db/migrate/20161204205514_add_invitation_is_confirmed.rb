class AddInvitationIsConfirmed < ActiveRecord::Migration
  def change
    add_column :account_registration_invitations, :is_confirmed, :boolean, default: false
  end
end
