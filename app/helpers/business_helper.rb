module BusinessHelper

  def is_feature_active?(business, feature)
    offer_type = business.plan_type
    case feature
      when 'team'
        return offer_type == BusinessProfile.plans_types[:pro]
      else
        # type code here
    end
  end

  def get_plan_type
    business_profile = current_user.business_profile
    plan = business_profile.plan_type
    has_free_account = business_profile.has_free_account
    #
    if current_user.in_trial_mode?
      return t('Pro Trial to') + ' ' + (business_profile.free_account_started_at + 30.day).strftime("%F")
    end
    string = nil
    expires = business_profile.expires
    if expires.nil?
      expires = Date.today
    end
    if plan.equal?(0)
      string = t('Free')
    else
      if plan.equal?(1)
        string = t('Basic') + expires.strftime("%F")
      else
        string = t('Pro') + expires.strftime("%F")
      end
    end
    string

  end
end
