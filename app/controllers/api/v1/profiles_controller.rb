class Api::V1::ProfilesController < Api::V1::BaseController
    
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

end
