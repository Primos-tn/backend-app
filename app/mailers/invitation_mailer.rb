class InvitationMailer < ApplicationMailer
  default :template_path => 'mailers/invitation_mailer'

  def invite_user(target)
    @target = target
    subject = I18n.t('New invitation')
    mail(to: target.email, subject: subject)
  end

  def send_join_request_user(target)
    @target = target
    mail(to: target.email, subject: I18n.t('New invitation'))
  end

  def confirm_valid_response(target)
    @target = target
    mail(to: target.email, subject: I18n.t('Request accepted'))
  end

end
