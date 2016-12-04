class  ContactMailer < ApplicationMailer
  default :template_path => 'mailers'
  default from: 'contact@example.com'
  # (template_path: 'notifications', template_name: 'another')
  def reply_contact(email)
    mail(template_name: 'contact', to: email, subject: I18n.t('Welcome'))
  end

  def notify_admin_contact
    admin_mail = Rails.application.secrets.admin['email']
    @config = BusinessSystem.first
    mail(to: admin_mail, subject: I18n.t('Update'))
  end
end
