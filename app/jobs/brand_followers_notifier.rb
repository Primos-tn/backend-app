class BusinessConfigurationChangeAlert < ApplicationJob
  UPDATE=1

  queue_as :default
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # http://stackoverflow.com/questions/37871943/activejob-deliver-later-not-sending

  def perform(*args)
    # get all users and  performs followers
  end

end
