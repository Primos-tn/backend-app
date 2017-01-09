class Dashboard::BrandGalleriesController < Dashboard::DashboardController
  include FilesUtils
  before_action :calculate_gallery_folder_size, only: [:create, :index]
  before_action :check_allowed_to_create, only: [:create]

  def index
    @gallery = current_brand.gallery
    if request.xhr?
      render 'index.json'
    end
  end

  def create
    @item = BrandGallery.new({:brand => current_brand, :file => params[:file]})
    if @item.save!
      respond_to do |format|
        format.html { redirect_to redirect_to_url, notice: t('Products created') }
        format.json { render json: @item.as_json }
      end
    else
      # TODO
    end
  end

  def destroy
    brand_gallery = BrandGallery.eager_load(:products, :brand).find(params[:id])
    redirect_to_url =  dashboard_brand_galleries_path
    if brand_gallery.products.length > 0
      respond_to do |format|
        format.html { redirect_to redirect_to_url, notice: t('Products attached') }
        format.json { render json: brand_gallery.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if brand_gallery.brand.id == current_brand.id and brand_gallery.destroy!
          format.html { redirect_to redirect_to_url, notice: t('Picture was successfully destroyed.') }
          format.json { head :no_content }
        else
          format.html { render json: brand_gallery.errors, notice:  brand_gallery.errors}
          format.json { render json: brand_gallery.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private


  def calculate_gallery_folder_size
    @gallery_size = dir_size?(File.join(Rails.application.secrets.storage['root'], current_brand.media_store_dir, 'gallery'))
  end

  def check_allowed_to_create
    render :json => {:error => 'limited excited'}, status: 500 if @gallery_size > 200
  end

  def set_tab
    @active_tab = 'gallery'
  end

end
