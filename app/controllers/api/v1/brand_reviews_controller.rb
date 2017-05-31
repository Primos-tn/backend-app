class Api::V1::BrandReviewsController < Api::V1::BaseController
  include RabbitMQDispatcher
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_brand

  def index
    reviews = @brand.reviews
    @mine = {}
    if current_user
      @mine = BrandReview.where(account: current_user, brand: @brand).first
      reviews = reviews.where.not(account: current_user, brand: @brand)
    else
      @mine = nil
    end
    @reviews = reviews.page(params[:page]).per(params[:limit])
  end


  # create a review
  def create
    review = BrandReview.where(account: current_user, brand: @brand).first_or_initialize
    respond_to do |format|
      if review.update_attributes(get_review_params)
        #format.html { redirect_to reviews_brand_path(@brand), notice: t('Your review successfully updated.') }
        format.json { render json: {ok: true}, status: :ok }
      else
        #format.html { redirect_to reviews_brand_path(@brand), notice: t('Error saving review.') }
        format.json { render json: {errors: {review: review.errors}, status: :unprocessable_entity} }
      end
    end
  end

  # destroy a review only if you are the author
  def destroy
    if BrandReview.find(account: current_user, brand: @brand).exists?
      # destory
    end
  end


  private

  def set_brand
    @brand = Brand.find(params[:brand_id])
  end


  def get_review_params
    @brand = params.require(:review).permit([:body, :eval])
  end
end