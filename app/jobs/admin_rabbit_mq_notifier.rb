class AdminRabbitMQNotifier < ApplicationJob
  include RabbitMQDispatcher
  # no sideqick
  self.queue_adapter= :async

  queue_as :default
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def perform(brand_id, action_name)
    brand = Brand.find(brand_id)
    notification = {
        user: brand.account_id.to_s,
        content: {
            action: action_name,
            data: brand
        }
    }
    rabbitmq_dispatch_admin_notifications(notification.to_json)
  end

end
