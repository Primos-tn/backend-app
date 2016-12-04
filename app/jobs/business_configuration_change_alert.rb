class BusinessConfigurationChangeAlert < ApplicationJob
  UPDATE=1

  queue_as :default
  rescue_from ActiveRecord::RecordNotFound, with: :not_found



  def perform(*args)
    # http://stackoverflow.com/questions/37871943/activejob-deliver-later-not-sending
    BusinessMailer.notify_business_admin.deliver_later
  end

=begin
    rescue_from ActiveRecord::RecordNotFound do |exception|
      message = "Foo with ID #{params[:id]} not found."
      logger.error message
      redirect_to not_found_url, info: message
    end
=end
end
