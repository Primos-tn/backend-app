class AddBusinessSystemMails < ActiveRecord::Migration
  def change
    add_column :business_systems, :crash_mails_alert, :json, default: '[]'
    add_column :business_systems, :account_expires_requests_mails_alert, :json, default: '[]'
    add_column :business_systems, :business_requests_mail_alert, :json, default: '[]'
    add_column :business_systems, :contacts_mail_alert, :json, default: '[]'
  end
end
