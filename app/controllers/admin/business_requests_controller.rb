class Admin::BusinessRequestsController < Admin::BaseController

  before_action :set_request, only: [:show, :accept, :decline]

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
    @requests = BusinessProfile
                    .search(params[:search])
                    .where(:pending => true)
                    .includes(:account)
                    .order(sort_column + ' ' + sort_direction)
                    .page(page)
                    .per(limit)

  end

  def show
    @request = BusinessProfile
                .find(params[:id])

  end

  def accept
    @request.pending = false
    @request.is_confirmed = true
    @request.save!
    BusinessMailer.confirm_business_request(@request.account, @request).deliver_now
    AdminMailer.business_request_confirmed(@request).deliver_now
    redirect_to admin_business_requests_path
  end

  def decline
    @request.is_confirmed = false
    BusinessMailer.decline_business_request(@request.account, @request).deliver_now
    AdminMailer.business_request_declined(@request)
    redirect_to admin_business_requests_path
  end

  protected

  def set_tab
    @active_tab = "businessrequests"
  end

  def set_request
    @request = BusinessProfile
                   .eager_load(:account)
                   .find(params[:id])
  end
end
