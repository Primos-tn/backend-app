namespace :configure do
  desc "Business system configuration"
  task system: :environment do
    system = SystemConfiguration.first_or_create
    system.update(
        :supported_languages => %w(fr ar en)
    )
    puts 'System has been configured'
  end
end