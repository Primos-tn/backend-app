class Dashboard::TargetizeController < Dashboard::DashboardController
  before_filter :check_if_must_upgrade

  def set_tab
    @active_tab = 'targetize'
  end
end
