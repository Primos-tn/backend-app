module DashboardHelper

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
  def get_tab_link (link)
      link =  link.downcase
      dashboard_url = '/dashboard/'
      # check for stores
      if link == 'shops'
        dashboard_brand_brand_stores_path (session[:brand_id])
      else
        dashboard_url + (link != 'dashboard' ? link.downcase : '')
      end

  end

  $dashboard_tabs = %w(Dashboard  Shops Products Users Hooks Team Targetize System )
  $dashboard_tabs_icons = %w(panel map view-list-alt user bolt user target  settings)

  $dashboard_tabs_soon = %w(Api-keys)
  $dashboard_tabs_soon_icons = %w(key)
end
