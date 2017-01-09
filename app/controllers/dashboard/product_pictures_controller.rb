class Dashboard::ProductPicturesController < Dashboard::DashboardController
  before_action :set_product
  before_action :can_it_edit?

  def create
    add_more_pictures(pictures_params[:pictures])
    @product.save!
    redirect_back(fallback_location: dashboard_products_url)
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    @product.save!
    redirect_back(fallback_location: dashboard_products_url)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def add_more_pictures(new_pictures)
    pictures = @product.pictures
    pictures += new_pictures
    @product.pictures = pictures
  end

  def remove_image_at_index(index)

    puts '*************************'
    puts '*************************'
    puts '*************************'
    puts '*************************'
    puts @product.pictures
    puts '*************************'
    puts '*************************'
    puts '*************************'
    puts '*************************'

    remain_pictures = @product.pictures # copy the array
    deleted_image = remain_pictures.delete_at(index) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    @product.pictures = remain_pictures
    @product.remove_pictures! if remain_pictures.empty?
  end
  
  # Only product of user
  def can_it_edit?
    redirect_to '/422.html' if @product.account.id != current_user.id
  end

  def pictures_params
    params.require(:product).permit({pictures: []}) # allow nested params as array
  end
end
