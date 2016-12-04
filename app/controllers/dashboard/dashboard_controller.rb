class Dashboard::DashboardController < ApplicationController
  # define layout
  layout 'dashboard'
  # verify weather the user is a business account
  before_filter :is_business_account?
  before_filter :has_expired?
  before_filter :select_brand
  # check for brand
  before_action :set_tab
  # define the helper method
  helper_method :current_brand

  @current_brand
  @show_sidebar = true

  def index
    render 'dashboard/index'
  end


  def is_business_account?
    if action_name != 'go_free'
      return true
    end
    unless current_user and current_user.is_business?
      redirect_to '/company/business'
    end
  end

  def select_brand
    @show_sidebar = true
    unless session[:brand_id]
      @show_sidebar = false
      # views/dashboard/select
      redirect_to  select_dashboard_brands_path
    end
  end


  def current_brand
    @current_brand ||= Brand.find(session[:brand_id]) if session[:brand_id]
  end

  protected

  def set_session_brand(id, name)
    session[:brand_id] = id
    session[:current_brand_name]= name
  end

  def check_if_must_upgrade(message=t('Feature not available for free account'))
    if current_user.is_business_free?
      flash["upgrade_message"] = message
      redirect_to  dashboard_upgrade_form_path
    end
  end

  def has_expired?
    if current_user.is_plan_expired?
      redirect_to  dashboard_expired_path
    end
  end

  private

  def set_tab
    @active_tab = 'dashboard'
  end
end
