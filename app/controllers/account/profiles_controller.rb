class  Account::ProfilesController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_profile, only: [:show, :edit, :update, :destroy]

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
    render "profiles/show"
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
	    params.require(:profile).permit(:last_name, :first_name, :birthdate).merge(:account_id => current_user.id)
    end
end
