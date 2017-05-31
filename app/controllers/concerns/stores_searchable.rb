module StoresSearchable
  extend ActiveSupport::Concern

  private

  def get_stores_near
    center = request.params[:map][:center].to_a
    distance = 35
    center = center.collect { |i| i.to_f }
    # get within 50 km near given position
    box = Geocoder::Calculations.bounding_box(center, distance)
    # find all stores id within the bounding box
    Store.within_bounding_box(box).map(&:id)
  end

  def get_stores_near_by_location(center)
    distance = 35
    # get within 50 km near given position
    box = Geocoder::Calculations.bounding_box(center, distance)
    # find all stores id within the bounding box
    Store.within_bounding_box(box).map(&:id)
  end


  def get_stores_of_brand_near_by_location(brand_id, center)
    unless brand_id
      return get_stores_near_by_location(center)
    end
    distance = 35
    # get within 50 km near given position
    box = Geocoder::Calculations.bounding_box(center, distance)
    # find all stores id within the bounding box
    Store.where({:brand_id => brand_id}).within_bounding_box(box).map(&:id)
  end

end