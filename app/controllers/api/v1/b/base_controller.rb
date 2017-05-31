class Api::V1::B::BaseController < Api::V1::BaseController
  # destroy action
  before_action :check_for_token, except: [:not_found]
  # Once the client has the token it sends both token and email
  # to the API for each subsequent request.
  def authenticate_user!
    # get token and options
    authenticate_or_request_with_http_token do |token, options|
      api_token = BusinessApiToken.where('token = ? AND expires_at > ?', token, Date.today).first
      if api_token #&& api_token.account.is_business?
        sign_in api_token.account
        !did_expired?
      else
        unauthenticated!
      end
    end
  end

  def did_expired?
    if current_user.business_profile.expires.nil? or current_user.business_profile.expires < Date.today
      api_error(401, 'Not authorized', 'EXPIRED')
    else
      false
    end
  end


  # Check if the user has an authorization in the header
  def check_for_token
    if request.authorization
      authenticate_user!
    end
  end
end
