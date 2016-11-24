class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /category_products
  # GET /category_products.json
  def index
    @categories = Category.all
  end

  # GET /category_products/1
  # GET /category_products/1.json
  def show
  end

  # GET /category_products/new
  def new
    @category = Category.new
  end

  # GET /category_products/1/edit
  def edit
  end

  # POST /category_products
  # POST /category_products.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category product was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_products/1
  # PATCH/PUT /category_products/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_category_path(@category), notice: 'Category product was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_products/1
  # DELETE /category_products/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_category_url, notice: 'Category product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :desc)
    end
end
