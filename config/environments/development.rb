Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # mailer

  config.action_mailer.default_url_options = { :host => "localhost:3000" }
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
      :from => ENV['MAILER_SMTP_FROM'],
      :address => ENV['MAILER_SMTP_ADDRESS'],
      :port => ENV['MAILER_SMTP_PORT'],
      :authentication => ENV['MAILER_SMTP_AUTHENTICATION'],
      :enable_starttls_auto => ENV['MAILER_SMTP_ENABLE_STARTTLS_AUTO'],
      :user_name => ENV['MAILER_SMTP_USERNAME'],
      :password => ENV['MAILER_SMTP_PASSWORD']
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.log_level = :debug



  CarrierWave.configure do |config|
    config.root = Rails.application.secrets.storage['root']
  end

  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.add_footer = true
    Bullet.bullet_logger = true
  end

  config.wsapp = {
      host: 'wss://localhost/wsapp/'
  }

end
