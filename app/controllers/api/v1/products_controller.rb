class Api::V1::ProductsController < Api::V1::BaseController
  include StatisticsUtils
  include RabbitMQDispatcher
  #
  skip_before_action :authenticate_user!, only: [:index, :show, :reviews, :wishers, :product_of_day]
  before_action :set_product, except: [:index, :product_of_day] # only: [:wish, :unwish, :share, :notify, :reviews, :wishers]
  before_action :in_launch_mode?, only: [:show, :reviews, :stores, :wishers, :coupons]
  before_action :register_static_view, except: [:index, :unwish, :product_of_day]

  def index
    if request.params[:map]
      center = request.params[:map][:center].to_a
      distance = 50 #request.params[:map][:distance].to_i
      center  = center.collect{|i| i.to_f}
      # get within 50 km near given position
      box = Geocoder::Calculations.bounding_box(center, distance)
      # find all stores id within the bounding box
      stores_ids = Store.within_bounding_box(box).map(&:id)
    else
      stores_ids = nil
    end

    @products = ProductLaunch.launches_of_day({stores_ids: stores_ids})

    #
    collections_ids = []
    # e
    excludes_from_collections_ids = []
    # products without collection
    standalone_products = []
    @collections = {}


    
    @products.each do |entry|
      if not entry.products_collection_id.nil?
        collections_ids << entry.products_collection_id
        excludes_from_collections_ids << entry.product_id
        @collections[entry.products_collection_id] = []
      else
        standalone_products << entry.product_id
      end
    end
    # get all items with brands
    products_in_collections = ProductLaunch
                                  .joins(product: :brand)
                                  .eager_load!(product: [:brand, :pictures])
                                  .where({launch_date: Date.today})
                                  .where({products_collection_id: collections_ids})
                                  .where
                                  .not({product_id: excludes_from_collections_ids})
                                  .order('products.user_product_views_count DESC')

    # get id form products in collection s
    products_in_collections.each do |entry|
      @collections[entry.products_collection_id] << entry
    end

    # find user with relation to current user
    @me_and_products = {}
    if current_user
      mine = current_user.get_products_i_voted_from_list(standalone_products)
      mine.map do |entry|
        @me_and_products[entry[:product_id]] = true
      end
    end
    # get all items that items

  end

  # TODO , fix the search
  def index_old
    # includes will use a LEFT OUTER JOIN query if you do a condition on the table that the includes association uses:
    #@products = Product.eager_load(:brand).page(params[:page] || 1).per(2)
    search = {}
    search[:brand] = params[:brand]
    search[:categories] = params[:categories]
    ids_query = Product.get_sql_query(params[:limit], params[:page], params)
    ids_query_results = ActiveRecord::Base.connection.execute(ids_query)
    products_ids = ids_query_results.map { |c| c['id'] }
    # render json: products_ids
    products = Product.where(id: products_ids).order(votes_count: :desc)
    @products = {}
    @top_wishers = {}
    ids_query_results.each { |c|
      unless @top_wishers.has_key?(c['id'])
        @top_wishers[c['id']] = []
      end
      @top_wishers[c['id']].append({:user_id => c['user_id'], :username => c['username']})
    }
    # get the first element to get information
    # then push element
    products.each { |entry|
      # if the key does't exist
      unless @products.has_key? entry.id
        @products[entry.id] = {
            :item => entry,
            :brand => entry.brand,
            :pictures => entry.pictures
        }
      end
    }

    ## check all current user like
    @me_and_products = {}
    if current_user
      mine = current_user.get_products_i_voted_from_list(@products.keys)
      mine.map do |entry|
        @me_and_products[entry[:product_id]] = true
      end
    end
  end

  def product_of_day
    @products = Product.where('date (last_launch) = current_date').order(:user_product_wishes_count).page(0).per(5)
  end

  def show
    @product = Product.includes(:stores, :comments).find(params[:id])
    @is_voted = false
    if current_user
      mine = current_user.get_products_i_voted_from_list([@product.id])
      if mine.count > 0
        @is_voted = true
      end
    end
  end

  #
  # Notify me
  #
  def notify

  end

  #
  # Share
  #
  def share

  end


  # get a product reviews

  def wishers
    @items = UserProductWish.includes(:account).where({product: @product}).all
  end

  # get a product reviews

  def reviews
    @items = ProductComment.includes(:account).where({product: @product}).all
  end

  # get a product coupon

  def coupons
    @items = @product.product_coupons
  end


  def stores
    @items = @product.stores
  end

  #
  # Wish list
  #
  def wish
    next!
  end


  #
  # Wish list
  #
  def unwish
    next!
  end


  #
  # Wish list
  #
  def vote
    vote = UserProductVote.new({account: current_user, product: @product})
    if vote.save
      notification = {
          content: {
              :action => ApiConstants::PRODUCT_VOTE_UP,
              :data => {:product_id => @product.id}
          }
      }
      render json: notification, status: 200
      rabbitmq_dispatch_user_notifications(notification.to_json)
    else
      reply_error (I18n.t('errors.messages.duplicate'))
    end

  end

  #
  # Wish list
  #
  def unvote
    vote = UserProductVote.find_by({account: current_user, product: @product})
    if vote && vote.destroy!
      notification = {
          content: {
              :action => ApiConstants::PRODUCT_VOTE_DOWN,
              :data => {:product_id => @product.id}
          }
      }
      render json: notification
    else
      reply_error (I18n.t('errors.messages.duplicate'))
    end
  end


  private

  def set_product
    @product = Product.find(params[:id])
  end

  def register_static_view
    account_id = current_user.id if current_user
  else
    nil

    view = UserProductView
               .where(:ip_address => ip, :product => @product, :account_id => account_id)
               .first_or_create(:count => 1)
    view.increment!(:count, by = 1)
  end


  def in_launch_mode?
    unless @product.in_launch_mode?
      render json: {:response => t('Oh no! product can\'t be shown')}, status: 401
    end
  end

end
