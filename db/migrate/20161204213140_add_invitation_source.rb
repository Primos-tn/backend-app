class AddInvitationSource < ActiveRecord::Migration
  def change
    add_column :account_registration_invitations, :invitation_source, :integer, default:0
  end
end
