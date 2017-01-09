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
    link = link.downcase
    dashboard_url = '/dashboard/'
    # check for stores
    dashboard_url + (link != 'dashboard' ? link.downcase : '')

  end


  def get_class_active (tab)
    if $dashboard_tabs_soon.include?(tab.downcase)
      'Dashboard__ComingSoonFeature'
    end
  end

  $dashboard_tabs = %w(Dashboard Stores Products Gallery Users  System Hooks Targetize Domain   )
  $dashboard_tabs_icons = %w(panel map view-list-alt spray user settings bolt   target  paint-roller )

  # $dashboard_tabs = %w(Dashboard Stores Products Gallery Users  Hooks Targetize Domain Team System  )
  # $dashboard_tabs_icons = %w(panel map view-list-alt spray user bolt   target  paint-roller spray settings)

  $dashboard_tabs_soon = %w(targetize domain team hooks)
end
