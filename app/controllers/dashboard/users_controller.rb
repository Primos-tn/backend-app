class Dashboard::UsersController  < Dashboard::DashboardController

  # GET /products
  # GET /products.json
  def index
    @users = current_brand.followers.eager_load(:account)
  end

  private
  def set_tab
    @active_tab = 'users'
  end

end
