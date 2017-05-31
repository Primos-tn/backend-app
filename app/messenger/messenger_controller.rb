class MessengerController < ActionController::Base
  include AbstractController::Rendering
  include ActionView::Layouts
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths
  include Singleton
  include StoresSearchable

  self.view_paths = "app/views"

  API_URL = 'https://maps.googleapis.com/maps/api/geocode/json?address='.freeze
  REVERSE_API_URL = 'https://maps.googleapis.com/maps/api/geocode/json?latlng='.freeze

  def self.get_token
    ENV['FACEBOOK_MESSENGER_PAGE_TOKEN']
  end

  def reverse_address

  end

  def get_locale(sender_id)
    locale = I18n.locale
    unless sender_id.nil?
      account = MessengerAccount.find_by(user_id: sender_id)
      locale = account.locale unless account.locale.nil?
    end
    locale
  end

  # top brands
  def top_brands(sender_id=nil, categories_ids=nil)
    stores_ids = get_stores_near_by_location(get_location(sender_id))
    @items = Brand.top(5, categories_ids, stores_ids)
    I18n.with_locale(get_locale(sender_id)) do
      list = render_to_string(template: 'messenger/brands/index')
      JSON.parse(list)['list']
    end

  end


  # top brands
  def top_products(sender_id=nil, categories_ids)
    stores_ids = get_stores_near_by_location(get_location(sender_id))
    @items = ProductLaunch.look_now({categories_ids: categories_ids, stores_ids: stores_ids, limit: 5})
    I18n.with_locale(get_locale(sender_id)) do
      list = render_to_string(template: 'messenger/products/index')
      JSON.parse(list)['list']
    end
  end

  # top brands
  def sr(sender_id=nil, categories_ids)
    stores_ids = get_stores_near_by_location(get_location(sender_id))
    @items = ProductLaunch.look_now({categories_ids: categories_ids, stores_ids: stores_ids, limit: 5})
    I18n.with_locale(get_locale(sender_id)) do
      list = render_to_string(template: 'messenger/products/index')
      JSON.parse(list)['list']
    end
  end



  def brand_products(sender_id=nil, brand_id=nil)
    stores_ids = get_stores_of_brand_near_by_location(brand_id, get_location(sender_id))
    @items = ProductLaunch.look_now({categories_ids: categories_ids, stores_ids: stores_ids, limit: 5})
    I18n.with_locale(get_locale(sender_id)) do
      list = render_to_string(template: 'messenger/products/index')
      JSON.parse(list)['list']
    end
  end


  # top brands
  def get_categories(sender_id)
    locale = get_locale(sender_id)
    @items = Category.top_of_day_by_products(get_stores_near_by_location(get_location(sender_id)))
    #FIXME
    I18n.with_locale(locale) do
      list = render_to_string(template: 'messenger/categories/index', locale: locale)
      puts locale
      puts locale
      puts locale
      puts locale
      puts locale
      puts locale
      puts locale
      puts locale
      puts locale
      puts locale
      puts locale
      puts locale
      puts "#################"
      puts "#################"
      puts "#################"
      puts "#################"
      puts "#################"
      puts "#################"
      puts "#################"
      puts "#################"
      puts list
      puts list
      puts list
      puts list
      puts list
      puts list
      puts list
      puts list
      puts list
      puts list
      JSON.parse(list)['list']
    end
  end

  # top brands
  def get_category_search_choices(sender_id, category_id)
    locale = get_locale(sender_id)
    @category_id = category_id
    #FIXME
    I18n.with_locale(locale) do
      list = render_to_string(template: 'messenger/categories/search', locale: locale)
      JSON.parse(list)['list']
    end
  end

  def store_history(sender_id, body)
    account = MessengerAccount.find_or_create_by(user_id: sender_id)
    MessengerDiscussion.create({:messenger_account => account, :body => body})
    self.update_profile(sender_id, {last_connexion: Time.now})
  end

  def update_profile(sender_id, updates)
    MessengerAccount.find_by({user_id: sender_id}).update(updates)
  end


  def self.get_getting_started(sender_id, locale=nil)
    unless locale.nil?
      locale = get_locale(sender_id)
    end
    I18n.with_locale(locale) do
      list = render_to_string(template: 'messenger/common/hello')
      JSON.parse(list)['list']
    end
    # code here
  end

  def get_location(sender_id)
    [51.499766912405946, 0.04325866699218751]
  end
end