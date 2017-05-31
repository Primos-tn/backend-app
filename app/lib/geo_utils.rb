module GeoUtils

  def self.location_from_ip(request)
    if Rails.env.test? || Rails.env.development?
      location ||= Geocoder.search("50.76.167.161").first
    else
      location ||= request.location
    end
    location
  end

end