class Api::V1::B::ProductsController < Api::V1::B::BaseController
  include StatisticsUtils
  include RabbitMQDispatcher
  include Validators::Api::Business
  before_action :validate_params, only: [:create]

  def index
      render :json => current_user.brands.first.products.page(1).per(5)
  end

  def create

  end

  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: { error:  { unknown_parameters: pme.params } },
           status: :bad_request
  end

  private

  def validate_params
    product_params = Validators::Api::Business::Product.new(params)
    unless product_params.valid?
      render json: {error: location.errors}
    end
  end

end
