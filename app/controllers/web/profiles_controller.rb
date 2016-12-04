class  Web::ProfilesController < Web::BaseController
  before_filter :authenticate_user!
  before_action :set_profile

  # GET /profiles
  # GET /profiles.json
  def show
    if current_user.profile.nil?
      # create profile for user
      @profile = Profile.new
    else
      # raise error which doesn't make sense or redirect like
      @profile = current_user.profile
    end
  end

  # GET /profiles
  # GET /profiles.json
  def update
    if current_user.profile.nil?
      # create profile for user
      @profile = Profile.new
    else
      # raise error which doesn't make sense or redirect like
      @profile = current_user.profile
    end
    if @profile.update_attributes(profile_params) then
      flash[:notice] = I18n.t('Success saving')
    end

    render 'show'
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
	    params.require(:profile).permit(:last_name, :first_name, :address, :phone, :age).merge(:account_id => current_user.id)
    end

  # Never trust parameters from the scary internet, only allow the white list through.
  def set_profile

  end
end
