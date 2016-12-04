class Admin::AccountsController < Admin::BaseController

  # GET /accounts
  # GET /accounts.json
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
    @accounts = Account.search(params[:search]).order(sort_column + ' ' + sort_direction).page(page).per(limit)
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  protected

  def set_tab
    @active_tab = "accounts"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:category_id, :product_id)
  end
end
