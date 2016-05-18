class Api::V1::TasksController < Api::V1::BaseController
  before_filter :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    results = current_user
                  .tasks
                  .eager_load([:goods, :cart_line_items ])
                  .where(cart_line_items: {archived: false})
                  .as_json(
                      include: {
                          goods: {},
                          cart_line_items: {}
                      },
                  )
    results.each { |item|
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>>>>>>>>>>>>>>>>>><')
      lines = []
      if item.has_key?('cart_line_items')
        lines = item['cart_line_items'].index_by { |entry| entry['good_id'] }
        item['goods'].each { |good|
          good['desired_quantity'] = lines[good['id']]['quantity']
        }
        item.delete ('cart_line_items')
      end
    }
    render json: results
  end

  # GET /requests
  # GET /requests.json
  # return incoming delivery carts
  def scheduler
    render json: Task.where({repeat_every: Date.today.cwday, account: current_user})
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @task = Task.find ({account: current_user, id: params[:id]})
    render json: @task
  end

  # create a new cart
  # POST /task
  def create
    params = task_params
    details = params['cart_line_items_attributes']
    if details
      @task = Task.create(params)
      @task.account = current_user
      if (@task.description.length == 0) or not @task.description
        default_day = task_params[:repeat_every].to_i
        @task.description = Task::DAY_NAMES.key(default_day).to_s
      end

      if @task.valid?
        cart_lines = []
        details.each { |index, detail|
          cart_line = CartLineItem.new (detail)
          cart_line.task = @task
          cart_line.good_id = detail[:good_id]
          cart_line.price = detail[:unit_price]
          cart_lines.push(cart_line)
        }
        ActiveRecord::Base.transaction do
          @task.save()
          cart_lines.map { |cart_line| cart_line.save }
        end
        render json: cart_lines
      else
        api_error(errors: @task.errors)
      end
    else
      api_error(errors: 'empty cart')
    end
  end

  # Patch /tasks/1
  def update
    # update now
    @task.update(task_params)
    render json: @task
  end


  # GET /requests/1
  # GET /requests/1.json
  def details
    # @see http://stackoverflow.com/questions/6334537/rails-where-clause-on-model-association

    @items = CartLineItem
                 .eager_load(:good) # use eager load to gain an sql query
                 .where({archived: false}) # exclude archived
                 .joins(:task) # because the where clause includes Task
                 .merge(Task.where({:account => current_user, :id => params[:id]}))

    # use include not includes
    # use (:include => :good, :select => 'name, id') to include it in join
    render json: @items.to_json(include: {good: {only: [:id, :name, :unit_price, :unit_price_weight]}})
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:description, :repeat_every,
                                 :cart_line_items_attributes => [:id, :quantity, :good_id, :unit_price, :price])
  end
end
