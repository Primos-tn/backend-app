class Api::V1::ProductsController < Api::V1::BaseController
  #
  skip_before_filter :authenticate_user!, only: [:index, :show, :reviews, :wishers, :product_of_day]
  before_action :set_product, only: [:wish, :unwish, :share, :notify, :reviews, :wishers]


  # TODO , fix the search
  def index
    # includes will use a LEFT OUTER JOIN query if you do a condition on the table that the includes association uses:
    #@products = Product.eager_load(:brand).page(params[:page] || 1).per(2)
    search = {}
    search[:brand] = params[:brand]
    search[:categories] = params[:categories]
    products = Product.includes(:account).search(search).top_wishers(10, 0, params[:search])
    @products = {}
    # get the first element to get information
    # then push element
    products.each { |entry|
      # if the key does't exist
      unless @products.has_key? entry.id
        @products[entry.id] = {
            :item => entry,
            :brand => entry.brand,
            :wishers => []
        }
      end
      @products[entry.id][:wishers].append(entry)
    }
    ## check all current user like
    @me_and_products = {}
    if current_user
      mine = current_user.get_products_i_wish_given_list(@products.keys)
      mine.map do |entry|
        @me_and_products[entry[:product_id]] = true
      end
    end
  end


  def show
    @product = Product.includes(:stores, :comments).find(params[:id])
    render 'show.jbuilder'
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
    render 'wishers.jbuilder'
  end

  # get a product reviews

  def reviews
    @items = ProductComment.includes(:account).where({product: @product}).all
    render 'reviews.jbuilder'
  end

  # get a product coupon

  def coupons
    @items = Coupon.where({product: @product}).all
    render 'coupons.jbuilder'
  end

  #
  # Wish list
  #
  def wish
    wish = UserProductWish.new({account: current_user, product: @product})
    if wish.save
      reply_success ({id: wish.id})
    else
      reply_error (I18n.t('duplicate'))
    end

  end

  def product_of_day

  end
  #
  # Wish list
  #
  def unwish
    wished = UserProductWish.find({account: current_user, product: @product})
    reply_success (wished)
    return
    if wished && wished.destrory!
      reply_success (wished)
    else
      reply_error (I18n.t('duplicate'))
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

end
