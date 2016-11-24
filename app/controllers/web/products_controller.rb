class Web::ProductsController < Web::BaseController
  before_action :set_id, only: [:show, :reviews, :stores, :wishers, :coupons]

  def index

  end

  def show

  end

  def stores
    @active_tab = __method__
    render 'show'
  end

  def coupons
    @active_tab = __method__
    render 'show'
  end

  def reviews
    @active_tab = __method__
    render 'show'
  end


  def wishers
    @active_tab = __method__
    render 'show'
  end

  private

  def set_id
    @product = Product.includes([:brand]).find(params[:id])
    @id = params[:id]
  end
end
