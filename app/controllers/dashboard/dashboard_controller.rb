class Dashboard::DashboardController < ApplicationController
  # define
  layout 'dashboard'

  def dashboard_payment
    render 'pricing'
  end
  def targetize
    render 'targetize'
  end
end
