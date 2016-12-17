class Dashboard::NotificationsController  < Dashboard::DashboardController
  include NotificationsControllerModule
  # @notifications

  protected

  def set_tab
    @active_tab = "notifications"
  end
end
