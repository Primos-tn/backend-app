class Api::V1::ProfilesController < Api::V1::BaseController
  before_action :set_profile, only: [:update, :interests]

  def show
    user = Account.find(params[:id])
    render json: user.profile
  end

  # Return user wishers
  #

  def wishes
    @wishes = current_user.wishes
    render 'wishes.jbuilder'
  end

  def brands
    @brands = current_user.my_brands
    render 'brands.jbuilder'
  end


  # GET /profiles
  # GET /profiles.json
  def update
    respond_to do |format|
      if @profile.update_attributes(profile_params)
        format.html {
          flash[:notice] = t('Profile was successfully update.')
          redirect_to home_path
        }
        format.json { render json: {ok: true}, status: :ok }
      else
        format.html { redirect_to profile_edit_url, notice: t('Profile not saved !') }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end

  end

  def interests
    respond_to do |format|
      if current_user.update_attributes(get_interested_categories_form_params) and
          @profile.update_attributes(get_region_interest_form_params)
        format.html { redirect_to root_path, notice: t('Yout interests was successfully updated.') }
        format.json { render json: {ok: true}, status: :ok }
      else
        format.html { render json: {errors: {profile: @profile.errors, account: current_user.errors}, status: :unprocessable_entity} } # { redirect_to profile_interests_path, notice: t('Error') }
        format.json { render json: {errors: {profile: @profile.errors, account: current_user.errors}, status: :unprocessable_entity} }
      end
    end
  end

  private

  def set_profile
    if current_user.profile.nil?
      # create profile for user
      @profile = Profile.new
    else
      # raise error which doesn't make sense or redirect like
      @profile = current_user.profile
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params
        .require(:profile)
        .permit(:last_name, :first_name, :address, :phone, :age)
        .merge(:account_id => current_user.id)
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def get_interested_categories_form_params
    params.require(:account).permit(category_ids: [])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def get_region_interest_form_params
    params.require(:profile).permit(:region_interest)
  end


end
