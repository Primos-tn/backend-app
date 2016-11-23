class  Web::BaseController < ApplicationController
# Once the client has the token it sends both token and email
# to the API for each subsequent request.
  def authenticate_user!
    if current_user.nil?
      unauthenticated!
    end
  end

  #
  # Not authorized application
  #
  def unauthenticated!
    redirect_to  new_user_session_path
  end
end
