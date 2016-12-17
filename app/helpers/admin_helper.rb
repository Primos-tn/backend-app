module AdminHelper
  def get_admin_sidebar_item(active, current='none')
    if current.to_s == active.to_s
      'active'
    else
      ''
    end
  end

  #
  #
  #
  def get_admin_tab_link (index)
    $admin_menu_links[index]
  end

  $admin_menu_names = %w(Dashboard  BusinessRequests Invitations BusinessAccounts Contacts  Brands Accounts Categories BusinessConfiguration System)
  $admin_menu_icons = %w(panel flag  email briefcase  email map user view-list-alt settings  settings)
end
