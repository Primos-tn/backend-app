module DashboardHelper


  $dashboard_tabs = %w(Dashboard Stores Products Gallery Users  Api System Hooks Targetize)
  $dashboard_tabs_links = %w(Dashboard Stores Products Gallery Users  Api System Hooks Targetize)
  $dashboard_tabs_icons = %w(panel map view-list-alt spray user cloud settings  bolt target)

  $dashboard_tabs_soon = %w(targetize team hooks)
  $features_pro_only = %w(api)

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
    elsif $features_pro_only.include?(tab.downcase)
      plan = current_user.business_profile.plan_type
      if plan == BusinessProfile.plans_types[:basic] or
          plan == BusinessProfile.plans_types[:free]
        'Dashboard__ComingSoonFeature'
      end
    end
  end


  def tag_links(tags)
    tags.split(",").map { |tag| link_to tag.strip, tag_path(tag.strip) }.join(", ")
  end

end
