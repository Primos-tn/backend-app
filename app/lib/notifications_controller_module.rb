module  NotificationsControllerModule

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
    @notifications = Notification.where(:account => current_user).order(sort_column + ' ' + sort_direction).page(page).per(limit)
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

end
