class Api::V1::PushTokensController < Api::V1::BaseController
  #
  skip_before_filter :authenticate_user!, only: [:index, :show]

  def index

  end

  def show
    render 'info'
  end

  private
  def set_user
    @user = Account.find(params[:id])
  end

end
