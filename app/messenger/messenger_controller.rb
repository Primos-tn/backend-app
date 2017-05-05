class MessengerController < ActionController::Base
  include AbstractController::Rendering
  include ActionView::Layouts
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths
  include Singleton


  self.view_paths = "app/views"


  API_URL = 'https://maps.googleapis.com/maps/api/geocode/json?address='.freeze
  REVERSE_API_URL = 'https://maps.googleapis.com/maps/api/geocode/json?latlng='.freeze

  def self.get_token
    ENV['FACEBOOK_MESSENGER_PAGE_TOKEN']
  end

  def reverse_address

  end

  def top_brands(host, sender_id=nil)
    @host = host
    unless sender_id.nil?
      account = MessengerAccount.find_by(user_id: sender_id)
    end
    @items = Brand.top(5)
    list = render_to_string(template: 'messenger/brands/index')
    JSON.parse(list)['list']
  end

  def store_history(sender_id, body)
    account = MessengerAccount.find_or_create_by(user_id: sender_id)
    MessengerDiscussion.create({:messenger_account => account, :body => body})
  end
end