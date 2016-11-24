module Dashboard::ProductsHelper
  GRID = 'grid'
  LIST = 'list'
  # return the list
  def get_list_style(current)
    !current || current == LIST ? GRID : LIST
  end

  def get_list_style_icon(current)
    !current || current == LIST  ? 'ti-view-grid' : 'ti-view-list'
  end

end
