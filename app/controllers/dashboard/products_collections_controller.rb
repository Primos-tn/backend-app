class Dashboard::ProductsCollectionsController < Dashboard::DashboardController
  before_action :set_products_collection, only: [:show, :edit, :update, :destroy, :launch, :add_products, :remove_products]

  def index
    @collections = ProductsCollection.includes([:products]).where(:brand => current_brand).all
    @hide_back = false
    @products_collection = ProductsCollection.new
    @errors = []
    # check if an ajax request
    # FIXME check user and collection
    # FIXME me check user allowed
    if request.xhr?
      render 'index.json'
    end
  end

  # POST /products
  # POST /products.json
  def create
    @products_collection = ProductsCollection.new(products_collection_form_params)
    @products_collection.brand = current_brand
    respond_to do |format|
      if @products_collection.save
        format.html { redirect_to dashboard_products_collections_path, notice: t('Collection was successfully created.') }
        format.json { render :show, status: :created, location: @products_collection }
      else
        format.html { render :new }
        format.json { render json: @products_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /collections/:id/add-products
  def add_products
    if product = Product.where({id: params[:product_id], brand: current_brand}).first
      begin
        @products_collection.products << product
        render json: {products: @products_collection.products}
      rescue ActiveRecord::RecordInvalid => exception
        render json: {error: exception}
      end
    end
  end

  # POST /collections/:id/remove-products
  def remove_products
    product_id = params[:product_id]
    if @products_collection.products_collections_products.where({product_id: product_id}).exists?
      if @products_collection.products_collections_products.where({product_id: product_id}).destroy_all
        return render json: {products: @products_collection.products}
      end
    end
    render json: {error: t('Server Error')}
  end

  # POST /products
  # POST /products.json
  def launch
    respond_to do |format|
      if @products_collection.can_be_launched?
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

  # GET /products/1/edit
  def edit
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @products_collection.update(products_collection_form_params)
        format.html { redirect_to dashboard_products_collections_path, notice: t('Collection was successfully updated.') }
        format.json { render :show, status: :ok, location: @products_collection }
      else
        format.html { render :edit }
        format.json { render json: @products_collection.errors, status: :unprocessable_entity }
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

  # Only product of user
  def require_permission
    # redirect_to '/422.html' if @product.account.id != current_user.id
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_products_collection
    @products_collection= ProductsCollection.where({id: params[:id], brand: current_brand}).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def products_collection_form_params
    params.require(:products_collection).permit(:name)
  end

end
