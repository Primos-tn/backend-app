class Api::V1::GeoController < Api::V1::BaseController


  # get an address form http request params
  def search
    if params.has_key?(:address)
      results = Geocoder.search(params[:address])
      render json: results
    else
      api_error(400, {:message => t('geo.no address provided')})
    end

  end

  # get an address form http request params
  def address
    if params.has_key?(:latitude) && params.has_key?(:longitude)
      results = Geocoder.address("#{params[:latitude]}, #{params[:longitude]}")
      if results.nil?
        api_error(404)
      else
        render json: {:address => results }
      end
    else
      api_error(400, {:message => t('geo.no coordinates provided')})
    end

  end

  # Based on ip address
  def mine

    render json: ['ok']
  end

end
