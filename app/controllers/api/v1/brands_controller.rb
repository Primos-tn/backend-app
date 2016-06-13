class Api::V1::BrandsController < Api::V1::BaseController

  before_filter :authenticate_user!

  def index
    brands = Brand.all()
    respond_with brands
  end
        
  def follow 
      msg = { :status => "ok", :message => "Success!", :id => params[:id] }
      render :json => msg
  end 
  
  def unfollow 
      msg = { :status => "ok", :message => "Success!", :id => params[:id] }
      render :json => msg
  end 
  
end
