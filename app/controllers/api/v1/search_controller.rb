class Api::V1::SearchController < Api::V1::BaseController
  skip_before_filter :authenticate_user!

  def index
    ids_query =  Product.get_sql_query(params[:limit], params[:page], params)
    ids_query_results = ActiveRecord::Base.connection.execute(ids_query)
    render json: ids_query_results
  end

end
