class Dashboard::BrandsController < Dashboard::DashboardController
  skip_before_filter :select_brand
  before_action :can_add_more?, only: [:new, :create]
  before_action :set_brand, only: [:show, :edit, :update,  :upload]
  before_action :require_permission, only: [:show, :edit, :update, :upload]


=begin
  # GET /brands
  # GET /brands.json
  def select
    if request.post?
      brand_id = params[:brand]
      brand = Brand.includes(:acount).where({account: current_user, id: brand_id}).first
      unless brand.nil?
        set_session_brand(brand.id, brand.name)
        redirect_to dashboard_main_path
      end
    end
    @brands = current_user.brands

  end
=end

  # GET /brands/1
  # GET /brands/1.json
  def show
  end

  # GET /brands/new
  def new
    if current_user.brands.count > 0
      redirect_to  dashboard_main_path
    end

    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit

  end
  # POST /brands
  # POST /brands.json
  def create
      @brand = Brand.new(brand_params)
      @brand.account = current_user
      respond_to do |format|
        if @brand.save
          format.html { redirect_to dashboard_main_path, notice: I18n.t('Brand was successfully created.') }
          format.json { render :show, status: :created, location: @brand }
        else
          format.html { render :new }
          format.json { render json: @brand.errors, status: :unprocessable_entity }
        end
      end

  end

  # POST /brands/1/upload
  def upload
    respond_to do |format|
      if current_brand.update_attributes(brand_pictures_params)
        #dashboard_main_path, notice: 'Brand was successfully updated.'
        format.html { redirect_to dashboard_main_path, notice: I18n.t('Brand was successfully created.') }
        format.json { render :show, status: :ok, location: current_brand }
      else
        format.html { render json: current_brand }
        format.json { render json: current_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    respond_to do |format|
      if current_brand.update(brand_params)
        current_brand.save!
        format.html { render json: current_brand } #{ redirect_to dashboard_main_path, notice: I18n.t('Brand was successfully updated.') }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render json: @brand.errors, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end
  #
  # # DELETE /brands/1
  # # DELETE /brands/1.json
  # def destroy
  #   if @brand.account == current_user
  #     if @brand.destroy
  #       respond_to do |format|
  #         format.html { redirect_to dashboard_brands_url, notice: I18n.t('Brand was successfully destroyed.') }
  #         format.json { head :no_content }
  #       end
  #     end
  #   end
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_brand
      @brand = current_brand
  end

  def set_tab
    @active_tab = 'brands'
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def brand_params
    params.require(:brand).permit(:name, :cover)
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def brand_pictures_params
    params.require(:brand).permit(:cover, :picture)
  end

  def can_add_more?
    if current_user.is_business_free? && current_user.brands.count > 0
      check_if_must_upgrade(I18n.t('Limited brand count'))
    end
  end

  def require_permission
    if current_user.id != @brand.account.id
      redirect_to ('/422.html')
      #Or do something else here
    end
  end
end
