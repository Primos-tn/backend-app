 class  Dashboard::BrandsController < Dashboard::DashboardController
  before_action :authenticate_user!, :except => [:index]
  before_filter :require_permission, only: [:edit, :update, :destroy]
  before_action :set_brand, only: [:show, :edit, :update, :destroy] , except: [:search]
  after_action :set_brand, only: [:update, :edit, :destroy]
  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.all
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands/1/follow
  def follow
      connection = UserBrandFollowingRelationship.new(account=current_user, brand=Brand.find(params[:id]))
      connection.save
  end


  # POST /brands/1/follow
  def unfollow
    connection = UserBrandFollowingRelationship.find(account=current_user, brand=Brand.find(params[:id]))
    if connection
      connection.destroy
    end
  end
  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: 'Brand was successfully created.' }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: 'Brand was successfully updated.' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, notice: 'Brand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
  def brand_params
      params.require(:brand).permit(:name)
  end

  def require_permission
    if current_user == Brand.find(params[:id]).account
      redirect_to ('/422.html')
      #Or do something else here
    end
  end
end
