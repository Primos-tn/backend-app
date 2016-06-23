class Api::V1::BrandsController < Api::V1::BaseController

  before_filter :authenticate_user!
  ## FIXME , we need to get only count of users
  def index
    page = params[:page]
    if page.nil?
      page = 1
    else
      page = [page.to_i, 1].max
    end


    @brands = Brand.eager_load(:account, :followers).limit(10).offset((page -1) * 10)
    brands_ids = []
    @brands.map do |brand|
      brands_ids.append (brand.id)
    end
    followings = UserBrandFollowingRelationship.where({account: current_user.id, brand: brands_ids }).all
    @followings_brands_by_brand_id = {}
    followings.map do |following|
      @followings_brands_by_brand_id[following[:brand_id]] = true
    end
    render 'index.jbuilder'

  end

  def show
    id = params[:id]
    result = {
        'id' => id
    }
    render :json => result
  end

  # get all followers
  def followers
    @followers = UserBrandFollowingRelationship.where(:brand_id => params[:id]).all
    render 'followers.jbuilder'
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
