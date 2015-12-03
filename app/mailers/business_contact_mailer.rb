class BusinessContactMailer < ApplicationMailer
	
  default from: 'support@badal.com'
	
  def reply_invitation(email)
    mail(to: email, subject: 'Welcome to gingo')
  end
end
