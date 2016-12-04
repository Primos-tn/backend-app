class  InvitationMailer < ApplicationMailer
  default :template_path => 'mailers'

  def invite_user(target)
    @target = target
    mail(to:target.email, subject: I18n.t('Invitation'))
  end
end
