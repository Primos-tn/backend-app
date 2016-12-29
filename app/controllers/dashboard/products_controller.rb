class Dashboard::ProductsController < Dashboard::DashboardController
  before_action :set_product_and_brand, only: [:show, :edit, :update, :destroy, :launch]
  before_action :require_permission, only: [:show, :edit, :update, :destroy, :launch]
  before_action :set_user_brands, only: [:new, :edit, :create]

  # GET /products
  # GET /products.json
  def index
    # select all products within current selected brand
    @products = current_user.products.includes(:categories, :account).where({brand: current_brand})
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
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to dashboard_product_path(@product), notice: 'Product was successfully created.' }
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
        @product.last_launch = Time.now
        @product.save
        format.html { redirect_to dashboard_product_path(@product), notice: 'Product was successfully launched.' }
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
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
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
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
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
  def product_params
    params.require(:product).permit(:name, :brand_id, {pictures: []})
  end
end
