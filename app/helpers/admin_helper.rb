module AdminHelper

  def get_active_sidebar_item(active, current='none')
    if current.to_s == active.to_s
      'active'
    else
      ''
    end
  end

  #
  #
  #
  def get_admin_tab_link (link)
      link =  link.downcase
      dashboard_url = '/admin/'
      dashboard_url + (link != 'dashboard' ? link.downcase : '')
  end

  $admin_tabs = %w(Dashboard  Brands Categories Accounts System)
  $dashboard_tabs_icons = %w(panel map view-list-alt user pencil-alt2 key user settings)
end
