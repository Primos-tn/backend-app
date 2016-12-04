class Dashboard::AccountsController < Dashboard::DashboardController

  skip_before_filter :has_expired?
  skip_before_filter :select_brand

  def go_free
    free_offer = BusinessProfile.plans_types[:free]
    # this user has a plan expired
    business =
        BusinessProfile
            .where({:account => current_user})
            .first_or_create(expires: Date.today.next_month, plan_type: free_offer)

    current_user.business_profile = business

    if current_user.is_plan_expired?
      business.plan_type = free_offer
      business.save!
      flash["notice"]= "moving to free offer"
    end

    redirect_to dashboard_main_path

  end


  def upgrade
    @message = flash["upgrade_message"]
    @business_profile = BusinessProfile.new(account: current_user)
  end


  def upgrade_form

  end


end
