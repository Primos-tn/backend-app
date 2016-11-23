class Dashboard::HooksController  < Dashboard::DashboardController

  # GET /products
  # GET /products.json
  def index
    @hooks = Hook.all
  end

  # GET /products/new
  def new
    @hook = Hook.new
  end

  private
  def set_tab
    @active_tab = 'hooks'
  end
end
