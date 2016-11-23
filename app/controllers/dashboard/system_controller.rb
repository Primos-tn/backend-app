class Dashboard::SystemController  < Dashboard::DashboardController

  before_filter :set_tab
  # GET /products
  # GET /products.json
  def index

  end

  private

  def set_tab
    @active_tab = 'system'
  end


end
