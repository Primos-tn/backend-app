class Api::V1::UsersController < Api::V1::BaseController
  #
  skip_before_filter :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:follow, :unfollow, :show]

  def index

  end


  def show
    render 'info'
  end


  def me
      @profile = current_user.profile
  end

  private
  def set_user
    @user = Account.find(params[:id])
  end

end
