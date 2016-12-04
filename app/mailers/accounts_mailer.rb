class  AccountsMailer < ApplicationMailer

  def welcome_user_and_validation(account)
    @account = account
    mail(template_path: 'mailers', to: @account.email, subject: I18n.t('Welcome'))
  end

  def new_user_notify_system(account)
    @account = account
    admin_mail = Rails.application.secrets.admin['email']
    mail(template_path: 'mailers', to: admin_mail, subject: I18n.t('Welcome'))
  end
end
