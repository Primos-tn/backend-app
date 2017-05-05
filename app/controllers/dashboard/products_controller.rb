class Dashboard::ProductsController < Dashboard::DashboardController
  include ProductsUtils
  require 'csv'
  before_action :set_product_and_brand, only: [:show, :edit, :update, :destroy, :launch]
  before_action :require_permission, only: [:show, :edit, :update, :destroy, :launch]
  before_action :set_user_brands, only: [:new, :edit, :create]

  # GET /products
  # GET /products.json
  def index
    @search_query = params[:search]
    page = params[:page]
    limit = params[:limit] || 10

    if page.nil?
      page = 1
    else
      page = [page.to_i, 1].max
    end
    sort_column = params[:sort] || ''
    sort_direction = params[:direction] || ''
    # select all products within current selected brand
    products = current_user
                   .products
                   .where({brand: current_brand})
                   .search(@search_query)
                   .includes(:pictures)

    total_count = products.count
    @page = page
    @count = total_count / limit + ((total_count % limit) > 0 ? 1 : 0)

    @products = products
                    .order(sort_column + ' ' + sort_direction)
                    .page(page)
                    .per(limit)

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end


  def import
    step = params['step'] || 1
    step = step.to_i
    # check for step
    if step == 1
      # check for request type
      if request.get?
        return render 'import_step_1'
      elsif request.post?
        # get import params
        import_params = products_import_form_params
        products = []
        # read csv file
        CSV.foreach(import_params[:file].path) do |row|
          products << row
        end
        if products.count < 3
          return render 'import_step_1'
        else
          @with_header = import_params[:with_header]
          # now store data
          data = {products: products, with_header: @with_header}
          temp_id = set_cached_products_for_import(data.to_s)
          @temp_id = temp_id
          @header = (1 .. products[0].count).to_a
          # if with header, get the first item
          if @with_header
            @header_names = products[0]
            @samples = [products[1], products[2]]
            @more = products.count - 3
          else
            # get from 0 to n
            @header_names = @header
            @samples = [products[0], products[1]]
            @more = products.count - 2
          end
          return render 'import_step_2'
        end
      else
        # no sense
      end
    else
      if step == 2
        # get the products cached
        data = get_cached_products_for_import(params[:uuid])

        if data.nil?
          render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
        end

        data = eval(data)
        with_header = data[:with_header]
        @products_lines = data[:products]
        # remove first line from
        if with_header
          @products_lines.shift
        end
        @attributes = {}
        @products_objects = []
        Product.import_names.each_with_index do |attr, index|
          attr_key = params['attr_' + index.to_s]
          unless attr_key.nil?
            if @attributes.has_value?(attr_key)
              @error = 'duplicate'
              return render 'import_step_3', status: 500
            else
              @attributes[index] = attr_key
            end
          end
        end
        #
        @products_lines.each do |product_line|
          puts product_line
          puts product_line
          puts product_line
          puts product_line
          puts product_line
          attributes = {}
          @attributes.each do |key_index, value|
            attributes[value] = product_line[key_index]
          end
          attributes[:brand] = current_brand
          @products_objects.push(Product.new(attributes))
        end

        ActiveRecord::Base.transaction do
          begin
            # This will raise a unique constraint error...
            @products_objects.each(&:save!)
          rescue ActiveRecord::StatementInvalid
            @error = 'db error'
            return render 'import_step_3', status: 500
          end
        end
        redirect_to dashboard_products_path
      else
        raise Exception(step)
      end
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_form_params)
    @product.brand = current_brand
    respond_to do |format|
      if @product.save
        format.html { redirect_to dashboard_product_path(@product), notice: t('Product was successfully created.') }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  # POST /products
  # POST /products.json
  def launch
    respond_to do |format|
      if @product.can_be_launched?
        launch_form_params = params.has_key?(:product) ? launch_params : {}
        at = launch_form_params[:last_launch]
        if not at.nil? and Time.strptime(at, '%m/%d/%Y')
          at = Time.strptime(at, '%m/%d/%Y')
        else
          at = Date.today
        end
        start_at = launch_form_params[:start_at] || at.beginning_of_day.strftime("%I:%M%p")
        end_at = launch_form_params[:end_at] || at.end_of_day.strftime("%I:%M%p")
        launch = ProductLaunch.new ({launch_date: at, product: @product, start_at: start_at, end_at: end_at})
        launch.save
        format.html { redirect_to dashboard_product_path(@product), notice: t('Product was successfully launched.') }
        format.json { render :show, status: :launched, location: @product }
      else
        format.html { redirect_to dashboard_product_path(@product), notice: 'Productcan not be launched launched.' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_form_params)
        format.html { redirect_to dashboard_product_path(@product), notice: t('Product was successfully updated.') }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: t('Product was successfully destroyed.') }
      format.json { head :no_content }
    end
  end

  private

  # Defines html active tab
  def set_tab
    @active_tab = 'products'
  end

  # Defines the current user brands
  def set_user_brands
    @brands = current_user.brands
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product_and_brand
    @product = Product.includes([:launches]).joins(:brand).where({id: params[:id], brands: {:account_id => current_user}}).first
    @brand = @product.brand
  end

  # Only product of user
  def require_permission
    redirect_to '/422.html' if @product.account.id != current_user.id
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def product_form_params
    params.require(:product).permit(:name, :properties, :brand_id, :old_price, :new_price, store_ids: [], picture_ids: [], category_ids: [])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def products_import_form_params
    params.permit(:file, :with_header)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def launch_params
    params.require(:product).permit(:last_launch, :start_at, :end_at)
  end

end
