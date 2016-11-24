class Api::V1::BrandsController < Api::V1::BaseController
  skip_before_filter  :authenticate_user!, only: ['index', 'show', 'followers', 'stores']

  def index
    page = params[:page]
    limit = params[:limit] || 10

    if page.nil?
      page = 1
    else
      page = [page.to_i, 1].max
    end
    # get brands
    @brands = Brand.eager_load(:account).page(page).per(limit)

    # get all brands ids
    brands_ids = []
    @brands.map do |brand|
      brands_ids.append (brand.id)
    end


    # build followers
    @followers = UserBrandFollowingRelationship.top_followers(3, brands_ids)
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
    @me_and_brands = {}

    if current_user
      mine = current_user.get_brands_i_follow_given_list(brands_ids)
      mine.map do |entry|
        @me_and_brands[entry[:brand_id]] = true
      end
    end

  end


  # show brand main action
  def show
    @brand = Brand.find(params[:id])
    render 'show.jbuilder'
  end

  # get all followers
  def followers
    @items = UserBrandFollowingRelationship.where(:brand => params[:id])
    render 'followers.jbuilder'
  end


  # get all followers
  def stores
    @items = BrandStore.where(:brand_id => params[:id])
    render 'stores.jbuilder'
  end


  # follow
  def follow
    id = params[:id]
    # check if the brand exists
    new_follower =  UserBrandFollowingRelationship.new ({:brand_id => id, :account_id => current_user.id})
    new_follower.save!
    result = {
        :ok => true
    }
    render :json => result
  end

  def unfollow
    # check if the brand exists
    new_follower = UserBrandFollowingRelationship.where(:account_id=>current_user.id).where(:brand_id=> params[:id]).first
    unless new_follower.nil?
      new_follower.destroy
    end
    result = {
        :ok => true
    }
    render :json => result
  end

end
