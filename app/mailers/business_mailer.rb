class BusinessMailer < ApplicationMailer
  default :template_path => 'mailers/business'

  def new_business_request(current_user, business_profile)
    @business_profile = business_profile
    mail(to: business_profile.business_email, subject: I18n.t('Update'))
  end


  def confirm_business_request(account, business_profile)
    @business_profile = business_profile
    mail(to: business_profile.business_email, subject: I18n.t('Update'))
  end


  def free_trial_business(account, business_profile)
    @business_profile = business_profile
    mail(to: business_profile.business_email, subject: I18n.t('Welcome'))
  end


  def business_upgraded(plan, business_profile)
    @business_profile = business_profile
    @plan = plan
    mail(to: business_profile.business_email, subject: I18n.t('Welcome'))
  end

  def decline_business_request(account, business_profile)
    @reason = ""
    mail(to: business_profile.business_email, subject: I18n.t('Update'))
  end


end
