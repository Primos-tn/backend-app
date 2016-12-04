class Dashboard::DemoController < Dashboard::DashboardController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  skip_before_filter :is_business_account?

  def index

  end
end
