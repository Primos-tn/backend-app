class Api::V1::SearchController  < Api::V1::BaseController

  # default search
  def index
    query = filter_params[:query] || ''
    size = (filter_params[:size] || 10).to_i
    offset = (filter_params[:offset] || 0).to_i
    # convert it to lower case
    query.downcase!
    # TODO add most search for
    @results = Good
                   .where('lower(name) like ? or lower(name_ar) like ? or lower(name_fr) like ? ', "#{query}%", "#{query}%", "#{query}%")
                   .limit(size) # size of page
                   .offset(offset * size) # start from

    render json: @results
  end
  # web default search
  def search
    @results =

        self.to_socket({
                           "message" => "test from rails",
                           "context" => "SEARCH"
                       })
    render json: @results
  end
  private
    def filter_params
      params.permit(:query, :size, :offset)
    end
end
