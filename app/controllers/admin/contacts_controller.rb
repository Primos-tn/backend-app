class Admin::ContactsController < Admin::BaseController
  before_action :set_contact, only: [:show]
  # GET /category_products
  # GET /category_products.json
  def index
    page = params[:page]
    limit = params[:limit] || 10

    if page.nil?
      page = 1
    else
      page = [page.to_i, 1].max
    end
    sort_column = params[:sort] || ''
    sort_direction = params[:direction] || ''
    @contacts = Contact
                    .search(params[:search]).order(sort_column + ' ' + sort_direction).page(page).per(limit)
  end

  # GET /brand/1
  # GET /brand/1.json
  def show
  end

  protected

  def set_tab
    @active_tab = "contacts"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact  = Contact.find(params[:id])
  end
end
