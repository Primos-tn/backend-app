class Dashboard::SystemController < Dashboard::DashboardController
  before_action :set_tab
  before_action :set_business_profile
  # GET /products
  # GET /products.json
  def index

  end

  def update
    respond_to do |format|
      if @business_profile.update_attributes(get_business_profile_params) and
          current_brand.update_attributes(get_brand_params)
        format.html { redirect_to  dashboard_system_path, notice: t('Information saved !') }
        format.json { render json: {brand: @business_profile, profile: @business_profile.as_json} }

      else
        format.html { render :index }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end

  end


  private

  def set_business_profile
    @business_profile = current_user.business_profile
  end

  def set_tab
    @active_tab = 'system'
  end

  def get_brand_params
    params.require(:brand).permit([:fb_link, :tw_link, :ln_link, :address, :creation_date, :category_id])
  end

  def get_business_profile_params
    params.require(:business_profile).permit([:business_phone, :business_email, :country, :post_code, :city, :company_address])
  end

end
