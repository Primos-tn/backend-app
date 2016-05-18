class Api::V1::UsersController < Api::V1::BaseController

  before_filter :authenticate_user!
    
  def show
    user = Account.find(params[:id])
    render json: user.profile
  end

end
