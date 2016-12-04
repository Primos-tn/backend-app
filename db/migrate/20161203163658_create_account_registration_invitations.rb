class CreateAccountRegistrationInvitations < ActiveRecord::Migration
  def change
    create_table :account_registration_invitations do |t|
      t.string :last_name
      t.string :first_name
      t.string :email
      t.integer :admin_sent_by
      t.timestamps null: false
    end
  end
end
