class Web::BrandsController < Web::BaseController
  before_action  except: [:index] do
    set_id([:business_profile])
  end

  def index
    @category = params[:category]
  end

  def show
    @review = @brand.reviews.build({:brand => @brand})
  end

  def info
    @active_tab = 'info'
    render 'show'
  end

  def reviews
    @active_tab = 'reviews'
    render 'show'
  end

  def followers
    @active_tab = 'followers'
    render 'show'
  end

  def products
    @active_tab = 'products'
    render 'show'
  end

  def stores
    @active_tab = 'stores'

    @stores = @brand.stores.collect { |entry| {id: entry.id, position: {longitude: entry.longitude, latitude: entry.latitude}} }
    render 'show'
  end

  private

  def set_id(includes=[])
    @brand = Brand.includes(includes).find(params[:id])
    @id = params[:id]
    @review = @brand.reviews.build({:brand => @brand})
  end
end

