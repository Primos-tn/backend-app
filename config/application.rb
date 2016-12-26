require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Primos
  class Application < Rails::Application
    puts "env.#{Rails.env}.yml"
    config.before_configuration do
      env_file = File.join(Rails.root, 'env', "#{Rails.env}.yml")
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value.to_s
      end if File.exists?(env_file)
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Autoload lib/ folder including all subdirectories
    config.autoload_paths += Dir["#{config.root}/lib/app/"]


    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.assets.initialize_on_precompile = false
    config.active_record.raise_in_transactional_callbacks = true

    # jobs
    config.active_job.queue_adapter = :sidekiq
  end

end
