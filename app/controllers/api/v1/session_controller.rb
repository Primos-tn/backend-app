# 
# File session_controller.rb
# @copyright izzY 2016
# @author hassenfath
# created at 2/12/16
# created at 
# FIXME , please add your description here
#  
class Api::V1::SessionController < Api::V1::BaseController

  before_action :authenticate_user!, only: [:destroy]

  # For authentication, the Rails app uses a custom implementation.
  # That shouldn't be a problem because we build an API
  # and we need to re-implement the authentication endpoint anyway.
  # In APIs you don't use cookies and you don't have sessions.
  # Instead, when a user wants to sign in she sends an HTTP POST request
  # with her username and password to our API (in our case it's the sessions endpoint)
  # which sends back a token. This token is user's proof of who she is.
  # In each API request, rails finds the user based on the token sent.
  # If no user found with the received token the API should return a 401 error.
  def create
    user = Account.find_by(email: create_params[:email])
    if user # TODO complete normal authentication && warden.authenticate!(create_params) #user.authenticate(create_params[:password])
      access_token = create_access_token(user)
      render(
          #json: Api::V1::SessionSerializer.new(user, root: false).to_json,
          json: access_token.to_json,
          status: 201
      )
    else
      unauthenticated!
    end
  end

  # Destroys a token
  # this may be triggered when the same devise is logged in
  def destroy
    @access_token.destroy
    render json: @access_token
  end

  private

  # Get prarams from header
  def create_params
    params.permit([:email, :password])
  end

  # Create a new success
  def create_access_token (user)
    token_value = SecureRandom.base64(64)

    access_token = AccessToken.new(account: user, value: token_value, expires_at: DateTime.now + 30)
    # You need to alert the user by its identifier
    # TODO , alert either the user will be connected using
    access_token.save!
    access_token
  end
end
