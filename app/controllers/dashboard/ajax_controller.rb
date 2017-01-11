class Dashboard::AjaxController < Dashboard::DashboardController

  def stats
    p_id = params[:product_id]
    if p_id
      product_info(p_id)
      render 'product_stats'
    else
      ok = brand_info
      render 'brand_stats'
    end
  end

  private

  def brand_info
    @reviews_count = current_brand.reviews.size
    @followers_count = current_brand.followers.size
    @products_count = current_brand.products.size
    @stores_count = current_brand.stores.size
  end

  def product_info(product_id)
    product = Product.exists?(brand: current_brand, id: product_id)
    if product
      @wishers_count = product.wishers.size
      @views_count = product.views.size
      @stores_count = product.stores.size
      @shares_count = product.shares.size
    else
      render text: 'not found ', status: 400
    end

  end
end