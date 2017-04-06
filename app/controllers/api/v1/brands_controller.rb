class Api::V1::BrandsController < Api::V1::BaseController
  include RabbitMQDispatcher

  skip_before_filter :authenticate_user!, only: ['index', 'show', 'followers', 'stores']
  before_action :set_brand, only: [:follow, :unfollow]


  def index
    page = params[:page]
    limit = params[:limit] || 10

    if page.nil?
      page = 1
    else
      page = [page.to_i, 1].max
    end
    # used to exclude stores of today
    # this used when user asked for a map with exclude_today query key
    @exclude_stores_ids = []

    @brands = Brand.eager_load ([:account, :stores])

    if request.params[:map]
      center = request.params[:map][:center].to_a
      distance = 50 #request.params[:map][:distance].to_i
      center = center.collect { |i| i.to_f }
      box = Geocoder::Calculations.bounding_box(center, distance)
      stores_ids = Store.within_bounding_box(box).map(&:id)
      @brands = @brands.joins([:stores]).where({:stores => {id: stores_ids}})
      # check if we need to exclude stores that has
      if request.params[:exclude_today]
        @exclude_stores_ids = Store.has_offers_toady.map(&:id)
      end

    end

    categories_ids = request.params[:categoriesList]

    unless categories_ids.blank?
      @brands = @brands.where(:category_id => request.params[:categoriesList])
    end

    @brands = @brands.page(page).per(limit)

    # get all brands ids
    brands_ids = []
    @brands.map do |brand|
      brands_ids.append (brand.id)
    end

    if brands_ids.length > 0
      # build followers
      @followers = BrandUserFollower.top_followers(3, brands_ids)
      @followers_by_brands_id = {}
      current_brand_id = nil
      @followers.map do |entry|
        current_brand_id = entry.brand_id
        unless @followers_by_brands_id.has_key?(current_brand_id)
          @followers_by_brands_id[current_brand_id] = []
        end
        # because we use outer join, some entry does'nt have this
        if entry.username
          @followers_by_brands_id[current_brand_id].push(entry)
        end
      end
      attach_my_brands(brands_ids)
    end
  end


  # show brand main action
  def show
    @brand = Brand.find(params[:id])
    attach_my_brands([@brand.id])
  end

  # get all followers
  def followers
    @items = BrandUserFollower.where(:brand => params[:id])
    render 'followers.jbuilder'
  end


  # get all followers
  def stores
    @items = Store.where(:brand_id => params[:id])
    render 'stores.jbuilder'
  end


  # follow
  def follow
    # check if the brand exists
    new_follower = BrandUserFollower.new ({:brand => @brand, :account => current_user})
    if new_follower.save
      @brand.reload
      action_name = ApiConstants::BRAND_FOLLOW
      response = {:action => action_name, :data => {:brand_id => @brand.id, :followers_count => @brand.followers.size}}
      render json: response, status: 200
      rabbitmq_dispatch_user_notifications(response.to_json)
      RabbitMQOwnerNotifier.perform_later @brand.id, action_name
    else
      reply_error (I18n.t('errors.messages.duplicate'))
    end
  end

  # unfollow brand
  def unfollow
    following = BrandUserFollower.find_by({account: current_user, :brand => @brand})
    if following.destroy
      @brand.reload
      response = {:action => ApiConstants::BRAND_UNFOLLOW, :data => {:brand_id => @brand.id, :followers_count => @brand.followers.size}}
      render json: response, status: 200
      rabbitmq_dispatch_user_notifications(response.to_json)
    else
      reply_error (I18n.t('errors.messages.duplicate'))
    end

  end

  private

  def set_brand
    @brand = Brand.find(params[:id])
  end

  def attach_my_brands(brands_ids)
    @me_and_brands = {}
    if current_user
      mine = current_user.get_brands_i_follow_given_list(brands_ids)
      mine.map do |entry|
        @me_and_brands[entry[:brand_id]] = true
      end
    end
  end
end