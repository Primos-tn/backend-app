class Dashboard::DashboardController < ApplicationController
  # define layout
  layout 'dashboard'
  # verify weather the user is a business account
  before_action :is_business_account?
  # verify weather the user is a blocked account
  before_action :is_blocked?
  # select brand
  before_action :select_brand
  # check for expiration
  before_action :has_expired?
  # check for brand
  before_action :set_tab
  # define the helper method
  helper_method :current_brand

  @current_brand
  @show_sidebar = true

  def index
    @stores = Store
                  .where({brand_id: current_brand.id})
    render 'dashboard/index'
  end




  def is_business_account?
    unless current_user and current_user.is_business?
      redirect_to business_index_path
    end
  end


  def is_blocked?
    if current_user.business_profile.is_blocked?
      redirect_to  dashboard_blocked_path
    end
  end


  def select_brand
    @show_sidebar = true
    unless current_user.brands.count > 0
      @show_sidebar = false
      # views/dashboard/select
      redirect_to new_dashboard_brand_path
    end
  end


  def current_brand
    @current_brand ||= Brand.where(:account => current_user).first
  end

  protected

  # FIXME
  def check_if_must_upgrade(message=t('Feature not available for free account'))
    if current_user.is_business_free? and not current_user.in_trial_mode?
      flash["upgrade_message"] = message
      redirect_to dashboard_upgrade_form_path
    end
  end

  def has_expired?
    if current_user.has_expired?
      redirect_to dashboard_expired_path
    end
  end

  private

  def set_tab
    @active_tab = 'dashboard'
  end
end
