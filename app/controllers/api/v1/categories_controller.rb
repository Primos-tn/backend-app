class Api::V1::CategoriesController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [:index]

  # TODO , fix the search
  def index
    @categories = Category.all
  end

end
