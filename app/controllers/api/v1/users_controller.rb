class Api::V1::UsersController < Api::V1::BaseController
  #
  skip_before_filter :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:show, :brands]

  def index

  end

  def brands
    page = params[:page] || 1
    limit = params[:limit] || 10
    @brands = @user.favorite_brands.page(page).per(limit)
  end

  def show
  end


  def me
      @profile = current_user.profile
      @user = current_user
  end

  private

  def set_user
    @user = Account.find(params[:id])
  end

end
