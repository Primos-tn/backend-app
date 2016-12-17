class Admin::BusinessAccountsController < Admin::BaseController
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
    @accounts = BusinessProfile
                .search(params[:search])
                .order(sort_column + ' ' + sort_direction)
                .page(page)
                .per(limit)

  end

  protected

  def set_tab
    @active_tab = "businessaccounts"
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def config_params
    params.require(:business_system).permit(:business_requests_mail_alert,
                                            :crash_mails_alert,
                                            :account_expires_requests_mails_alert,
                                            :contacts_mail_alert,
                                            :supported_countries,
                                            :offer_basic_price)
  end

end
