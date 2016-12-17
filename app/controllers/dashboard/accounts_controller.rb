class Dashboard::AccountsController < Dashboard::DashboardController
  skip_before_filter :is_blocked?, :only => [:blocked]
  skip_before_action :has_expired?
  skip_before_filter :select_brand
  before_action :can_upgrade, :only => [:upgrade, :upgrade_form]

  def blocked

  end

  def go_free
    free_offer = BusinessProfile.plans_types[:free]
    # this user has a plan expired
    business =
        BusinessProfile
            .where({:account => current_user})
            .first_or_create(expires: Date.today.next_month, plan_type: free_offer)

    current_user.business_profile = business

    if current_user.has_expired?
      business.plan_type = free_offer
      business.save!
      flash["notice"]= "moving to free offer"
    end

    redirect_to dashboard_main_path

  end

  def free_trial
    business_profile = current_user.business_profile
    if current_user.in_trial_mode?
      flash('error', 'alerady')
      redirect_to dashboard_main_path
    else
      if request.post?
        business_profile.has_free_account = true
        business_profile.free_account_started_at = Time.now
        if business_profile.save
          BusinessMailer.free_trial_business(current_user, business_profile).deliver_now
          AdminMailer.free_trial_business(business_profile).deliver_now
          redirect_to dashboard_main_path
        end
        # FIXME handles error
      end
    end
  end

  def upgrade
    business_profile =
        BusinessProfile
            .find_by_account_id(current_user.id)
    offer_plan = :basic
    business_profile.plan_type = BusinessProfile.plans_types[offer_plan]
    business_profile.expires = Date.today.next_month
    business_profile.save!
    BusinessMailer.business_upgraded(offer_plan, business_profile).deliver_now
    AdminMailer.business_upgraded(offer_plan, business_profile).deliver_now
    redirect_to dashboard_main_path


  end

  def upgrade_form

  end

  protected

  def can_upgrade
    if current_user.is_business_basic?
      render 'already_upgraded'
    end
  end


end
