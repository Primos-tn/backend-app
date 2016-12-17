class Dashboard::DomainController  < Dashboard::DashboardController

  def index

  end
  protected

  def set_tab
    @active_tab = 'domain'
  end

end
