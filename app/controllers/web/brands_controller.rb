class  Web::BrandsController < Web::BaseController
  before_action :set_id, except: [:index]


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
    render 'show'
  end

  private

  def set_id
    @brand = Brand.find(params[:id])
    @id = params[:id]
  end
end

