class Web::ProductsController < Web::BaseController
  before_action :set_id, only: [:show, :reviews, :stores, :wishers, :coupons]
  # move this to api in
  before_action :can_be_viewed?, only: [:show, :reviews, :stores, :wishers, :coupons]
  before_action :set_tab, only: [:stores, :coupons, :reviews, :wishers]

  def index

  end

  def show

  end

  def stores
    render 'show'
  end

  def coupons
    render 'show'
  end

  def reviews
    render 'show'
  end


  def wishers
    render 'show'
  end

  private

  def set_id
    @product = Product.includes([:brand]).find(params[:id])
    @id = params[:id]
  end

  def set_tab
    @active_tab = action_name
    @product = Product.includes([:brand]).find(params[:id])
    @id = params[:id]
  end

  def can_be_viewed?
    unless @product.in_launch_mode?
      render file: 'public/out_of_day.html'
    end
  end
end
