module Dashboard::BrandStoresHelper
  MAP = 'map'
  LIST = 'list'
  # return the list
  def get_shops_list_style(current)
    !current || current == LIST ? MAP : LIST
  end

  def get_shops_list_style_icon(current)
    !current || current == LIST  ? 'ti-map' : 'ti-view-list'
  end

end
