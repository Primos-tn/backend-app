class Dashboard::HooksController  < Dashboard::DashboardController
  # before_action  :check_if_must_upgrade
  # GET /products
  # GET /products.json
  def index
    @hooks = Hook.all
  end

  # GET /products/new
  def new
    @hook = Hook.new
  end

  def create

  end

  private
  def set_tab
    @active_tab = 'hooks'
  end
end
