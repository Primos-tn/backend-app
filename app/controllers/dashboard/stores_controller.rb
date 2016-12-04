class Dashboard::StoresController  < Dashboard::DashboardController
  before_action :set_brand
  before_action :set_store, only: [:show, :edit, :update, :destroy]


  # GET /dashboard/brands_stores
  # GET /dashboard/brands_stores.json
  def index
    if params[:style] &&  params[:style] == 'map'
      @view_style = 'map'
      @stores = Store
                          .where({brand_id: current_brand.id})
    else
        @stores = Store
                            .where({brand_id: current_brand.id})
                            .page(params[:page] || 1)
                            .per(2)
    end
  end

  # GET /dashboard/brands_stores/1
  # GET /dashboard/brands_stores/1.json
  def show
  end

  # GET /dashboard/brands_stores/new
  def new
    unless @brand
      redirect_to('/422.html')
    end
    @store = Store.new
  end

  # GET /dashboard/brands_stores/1/edit
  def edit
  end

  # POST /dashboard/brands_stores
  # POST /dashboard/brands_stores.json
  def create

    @store = Store.new(brand_store_params)
    @store.brand = @brand

    respond_to do |format|
      if @store.save
        format.html { redirect_to  dashboard_brand_brand_stores_path(@brand,@store), notice: I18n.t('Brands store was successfully created.') }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboard/brands_stores/1
  # PATCH/PUT /dashboard/brands_stores/1.json
  def update
    respond_to do |format|
      if @store.update(brand_store_params)
        format.html { redirect_to dashboard_brand_brand_stores_path(@brand), notice: I18n.t('Brands store was successfully updated.') }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboard/brands_stores/1
  # DELETE /dashboard/brands_stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_brands_stores_url, notice: I18n.t('Brands store was successfully destroyed.') }
      format.json { head :no_content }
    end
  end

  private


  def set_tab
    @active_tab = 'shops'
  end


  def set_brand
    @brand = Brand.find_by({:id => params[:brand_id], :account => current_user})
    if not @brand
      redirect_to ('/422.html')
    end
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def brand_store_params
    params.require(:brand_store).permit(:name)
  end
end
