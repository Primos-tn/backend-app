class Dashboard::AjaxController  < Dashboard::DashboardController

  def info
    @reviews_count = current_brand.reviews.size
    @followers_count = current_brand.followers.size
    @products_count = current_brand.products.size
    @stores_count = current_brand.stores.size
  end

end
