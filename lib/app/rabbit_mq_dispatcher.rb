module RabbitMQDispatcher

  def rabbitmq_dispatch_user_notifications (payload, *args)
    rabbitmq_dispatch(RabbitMQQueuesRoutingNames::MQ_USER_QUEUE_NAME, payload, *args)
  end

  def rabbitmq_dispatch_admin_notifications (payload, *args)
    rabbitmq_dispatch(RabbitMQQueuesRoutingNames::MQ_ADMIN_QUEUE_NAME, payload, *args)
  end

  def rabbitmq_dispatch_log (payload, *args)
    rabbitmq_dispatch(RabbitMQQueuesRoutingNames::MQ_LOG_QUEUE_NAME, payload, *args)
  end


  def rabbitmq_dispatch (name, payload, *args)
    q = $rabbitmq_channel.queue(name)
    # sending now
  $rabbitmq_channel.default_exchange.publish(JSON::dump(payload), :routing_key => q.name, :expiration => (2 * 60 * 1000))
end

end