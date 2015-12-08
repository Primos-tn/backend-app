class DashboardController < ApplicationController
  def dashboard
    render 'dashboard/default'
  end
  def dashboard_payment
    render 'dashboard/pricing'
  end
  def targetize
    render 'dashboard/targetize'
  end
end
