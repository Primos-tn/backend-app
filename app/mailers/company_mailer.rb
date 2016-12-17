class CompanyMailer < ApplicationMailer
  default :template_path => 'mailers/company'
  default from: 'contact@example.com'

  # (template_path: 'notifications', template_name: 'another')
  def reply_contact(email)
    mail(to: email, subject: I18n.t('Welcome'))
  end

  def new_contact(contact)
    @contact = contact
    mail(to: contact.email, subject: I18n.t('Welcome'))
  end

end
