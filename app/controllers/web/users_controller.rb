class  Web::UsersController < Web::BaseController
  before_action :set_profile

  # GET /profiles
  # GET /profiles.json
  def show

  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def set_profile
        @user = Account.find(params[:id])
  end
end
