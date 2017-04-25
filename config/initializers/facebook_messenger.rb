unless Rails.env.production?
  bot_files = Dir[Rails.root.join('app', 'messenger', '**', '*.rb')]
  bot_reloader = ActiveSupport::FileUpdateChecker.new(bot_files) do
    bot_files.each { |file| require_dependency file }
  end

  ActionDispatch::Callbacks.to_prepare do
    bot_reloader.execute_if_updated
  end

  bot_files.each { |file| require_dependency file }
end
#
# require "facebook/messenger"
# include Facebook::Messenger
#
# class ExampleProvider < Facebook::Messenger::Configuration::Providers::Base
#   def valid_verify_token?(verify_token)
#     bot.exists?(verify_token: verify_token)
#   end
#
#   def app_secret_for(page_id)
#     bot.find_by(page_id: page_id).app_secret
#   end
#
#   def access_token_for(page_id)
#     bot.find_by(page_id: page_id).access_token
#   end
#
#   private
#
#   def bot
#     YallaPingo::Bot
#   end
# end
#
# Facebook::Messenger.configure do |config|
#   config.provider = ExampleProvider.new
# end


class Custom
  def valid_verify_token?(verify_token)
    verify_token == ENV['FACEBOOK_MESSENGER_VERIFY_TOKEN']
  end

  def app_secret_for(*)
    ENV['FACEBOOK_APP_SECRET']
  end

  def access_token_for(*)
    ENV['FACEBOOK_MESSENGER_PAGE_TOKEN']
  end
end

Facebook::Messenger.configure do |config|
  config.provider = Custom.new
end

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['FACEBOOK_MESSENGER_PAGE_TOKEN'])