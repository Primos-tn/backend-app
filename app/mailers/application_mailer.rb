=begin
Mailers are queued in the queue mailers. Remember to start sidekiq processing that queue:

bundle exec sidekiq -q default -q mailers

=end
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'
end
