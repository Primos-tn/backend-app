class Dashboard::ProductsController < Dashboard::DashboardController
  before_action :set_product_and_brand, only: [:show, :edit, :update, :destroy, :launch]
  before_action :require_permission, only: [:show, :edit, :update, :destroy, :launch]
  before_action :set_user_brands, only: [:new, :edit, :create]

  # GET /products
  # GET /products.json
  def index
    # select all products within current selected brand
    @products = current_user.products.includes(:pictures).where({brand: current_brand})
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_create_params)
    @product.brand = current_brand
    respond_to do |format|
      if @product.save
        format.html { redirect_to dashboard_product_path(@product), notice: t('Product was successfully created.') }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
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
          at = Date.tomorrow
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

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_update_params)
        format.html { redirect_to dashboard_product_path(@product), notice: t('Product was successfully updated.') }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: t('Product was successfully destroyed.') }
      format.json { head :no_content }
    end
  end

  private

  # Defines html active tab
  def set_tab
    @active_tab = 'products'
  end

  # Defines the current user brands
  def set_user_brands
    @brands = current_user.brands
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product_and_brand
    @product = Product.joins(:brand).where({id: params[:id], brands: {:account_id => current_user}}).first
    @brand = @product.brand
  end

  # Only product of user
  def require_permission
    redirect_to '/422.html' if @product.account.id != current_user.id
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_create_params
    params.require(:product).permit(:name, :brand_id, {pictures: []}, store_ids: [], category_ids: [])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_update_params
    params.require(:product).permit(:name, :brand_id, :old_price, :new_price, store_ids: [], picture_ids: [], category_ids: [])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def launch_params
    params.require(:product).permit(:last_launch)
  end

end
