class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:show, :launch_date]
  # GET /category_products
  # GET /category_products.json
  def index
    page = params[:page]
    limit = params[:limit] || 10

    if page.nil?
      page = 1
    else
      page = [page.to_i, 1].max
    end
    sort_column = params[:sort] || ''
    sort_direction = params[:direction] || ''
    @products = Product
                    .includes([:brand])
                    .search(params[:search])
                    .order(sort_column + ' ' + sort_direction)
                    .page(page)
                    .per(limit)
  end

  # GET /brand/1
  # GET /brand/1.json
  def show
  end
  # POST /products
  # POST /products.json
  def launch
    respond_to do |format|
      if @product.can_be_launched?
        launch_form_params = params.has_key?(:product) ? launch_params : {}
        at = launch_form_params[:last_launch]
        if not at.nil? and Time.strptime(at, '%m/%d/%Y')
          at = Time.strptime(at, '%m/%d/%Y')
        else
          at = Date.today
        end

        @product.last_launch = at

        @product.save
        format.html { redirect_to dashboard_product_path(@product), notice: t('Product was successfully launched.') }
        format.json { render :show, status: :launched, location: @product }
      else
        format.html { redirect_to dashboard_product_path(@product), notice: 'Productcan not be launched launched.' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  protected

  def set_tab
    @active_tab = 'products'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product  = Product.find(params[:id])
  end
end
