class Dashboard::CouponsController < Dashboard::DashboardController
  before_action :set_product
  before_action :require_permission
  before_action :set_coupon , except: [:index, :new, :create]

  def index
    @coupons = @product.product_coupons
    @coupon = ProductCoupon.new
    @errors ||= []
    # in case of ther's a call from create
    render 'index'
  end

  def show
  end

  def edit
  end

  def new
  end


  def create
    coupon = ProductCoupon.create(product_coupon_params)
    coupon.product = @product
    if coupon.valid?
      coupon.save!
    end
    @errors = coupon.errors
    index
  end


  def update
  end
# DELETE /products/1
# DELETE /products/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_product_coupons_path(@product), notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Defines html active tab
  def set_tab
    @active_tab = 'products'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.includes(:account).find(params[:product_id])
  end

# Use callbacks to share common setup or constraints between actions.
  def set_coupon
    @coupon = ProductCoupon.where({:product => @product, :id => params[:id]}).first
  end
  # Only product of user
  def require_permission
    redirect_to '/422.html' if @product.brand.account.id !=  current_user.id or @product.account.id != current_user.id
  end



  # Never trust parameters from the scary internet, only allow the white list through.
  def product_coupon_params
    params.require(:product_coupon).permit(:value)
  end

end
