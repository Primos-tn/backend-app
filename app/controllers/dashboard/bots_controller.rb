class Dashboard::BotsController < Dashboard::DashboardController

  def index
    @token = 'nil'
    if current_user.provider == 'facebook'
      user_access_token = current_user.provider_access_token
      if user_access_token.nil?
        return facebook_required
      end
      @user_graph = Koala::Facebook::API.new(user_access_token)
      @pages = @user_graph.get_connections('me', 'accounts')
      if @pages.length == 0
        return facebook_required
      end
      @token = request.env["omniauth.auth"]
    else
      facebook_required
    end
  end

  def manage_page
    raise Exception
  end

  private
  def facebook_required
    @facebook_required = true
  end

  def set_tab
    @active_tab = 'bots'
  end
end
