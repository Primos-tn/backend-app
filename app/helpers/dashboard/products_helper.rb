module Dashboard::ProductsHelper
  GRID = 'grid'
  LIST = 'list'
  # return the list
  def get_list_style(current)
    !current || current == LIST ? GRID : LIST
  end

  def get_list_style_icon(current)
    !current || current == LIST ? 'ti-view-grid' : 'ti-view-list'
  end

  def get_defaults_product_properties
    [
        [t('default_propeties.height'), 'height'],
        [t('default_propeties.color'), 'color'],
        [t('default_propeties.weight'), 'weight'],
        [t('default_propeties.made'), 'made'],
        [t('default_propeties.width'), 'width']
    ]
  end


end
