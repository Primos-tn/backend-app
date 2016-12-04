class  BusinessMailer < ApplicationMailer
  default :template_path => 'mailers'
  def notify_business_admin
    admin_mail = Rails.application.secrets.admin['email']
    @config = BusinessSystem.first
    mail(to: admin_mail, template_name: 'business', subject: I18n.t('Update'))
  end
end
