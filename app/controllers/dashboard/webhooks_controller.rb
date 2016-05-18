class Dashboard::WebhooksController  < Dashboard::DashboardController

  # GET /products
  # GET /products.json
  def index
    @webhooks = Webhook.all
  end

  # GET /products/new
  def new
    @webhook = Webhook.new
  end
end
