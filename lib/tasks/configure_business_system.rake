namespace :configure do
  desc "Business system configuration"
  _system_configuration = Rails.application.secrets.business_system
  task business_system: :environment do
    business_system = BusinessSystem.first_or_create
    business_system.update(
        :business_requests_mail_alert => _system_configuration['business_requests_mail_alert'].split(','),
        :crash_mails_alert => _system_configuration['crash_mails_alert'].split(','),
        :account_expires_requests_mails_alert => _system_configuration['account_expires_requests_mails_alert'].split(','),
        :contacts_mail_alert => _system_configuration['contacts_mail_alert'].split(','),
        :supported_countries => _system_configuration['supported_countries'].split(','),
        :offer_basic_price => _system_configuration['offer_basic_price']
    )
    puts 'business system configuration done !'
  end
end