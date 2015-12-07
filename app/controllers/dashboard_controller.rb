class DashboardController < ApplicationController
  def dashboard_demo
    render 'dashboard/demo'
  end
  def dashboard_demo_pricing
    render 'dashboard/pricing'

  end
end
