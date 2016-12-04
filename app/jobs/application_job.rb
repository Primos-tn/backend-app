class ApplicationJob < ActiveJob::Base

  protected
  def not_found
    Rails.logger.error "[JOBS] Exception #{exception.class}: #{exception.message}"
  end
end
