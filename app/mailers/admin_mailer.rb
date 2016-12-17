class AdminMailer < ApplicationMailer
  default :template_path => 'mailers/admin'
  before_action :set_mail_to

  def business_system_config_changes
    @config = BusinessSystem.first
    mail(to: @admin_mail, subject: "Configuration changess !")
  end


  def new_contact(contact)
    @contact = contact
    mail(to: @admin_mail, subject: 'New contact')
  end


  def new_business_request(business_profile)
    @business_profile = business_profile
    mail(to: @admin_mail, subject: 'New business request')
  end

  def free_trial_business(business_profile)
    @business_profile = business_profile
    mail(to: @admin_mail, subject: 'New business request')
  end


  def business_request_declined(business_profile)
    @business_profile = business_profile
    mail(to: @admin_mail, subject: 'New business request')
  end

  def business_request_confirmed(business_profile)
    @business_profile = business_profile
    mail(to: @admin_mail, subject: 'New business request')
  end


  def business_upgraded(plan, business_profile)
    @business_profile = business_profile
    @plan = plan
    mail(to: @admin_mail, subject: I18n.t('Welcome'))
  end

  private

  def set_mail_to
      @admin_mail = Rails.application.secrets.admin['email']
  end

end
