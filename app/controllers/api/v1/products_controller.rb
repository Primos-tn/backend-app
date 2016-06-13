class Api::V1::ProductsController < Api::V1::BaseController

  before_filter :authenticate_user!

  def index
    brands = Product.all()
    render brands
  end

end
