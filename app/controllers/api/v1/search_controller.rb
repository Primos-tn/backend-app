class Api::V1::SearchController < Api::V1::BaseController
  skip_before_filter :authenticate_user!

  def index

  end

end
