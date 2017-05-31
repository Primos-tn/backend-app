class Dashboard::ApiController < Dashboard::DashboardController

  before_action :can_use_feature?

  def index

  end

  def can_use_feature?
    if current_user.has_expired? or current_user.business_profile.plan_type != BusinessProfile.plans_types[:pro]
      render 'upgrade'
    end
  end
end