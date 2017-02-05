class Web::ProfilesController < Web::BaseController
  before_action :authenticate_user!
  before_action :set_profile


  def interests

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
end
