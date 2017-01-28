# 
# File session_controller.rb
# @copyright izzY 2016
# @author hassenfath
# created at 2/12/16
# created at 
# FIXME , please add your description here
#  
class Api::V1::AccountsController < Api::V1::BaseController
  before_action :authenticate_user!, except: [:login, :create]
  #
  #
  #
  def create
    user = Account.new(register_params)
    if user.save
      render :json => user.as_json(:valid => t("success user account"), :email => user.email),
             :status => 201

    else
      warden.custom_failure!
      render :json => user.errors, :status => 422
    end
  end

  # For authentication, the Rails app uses a custom implementation.
  # That shouldn't be a problem because we build an API
  # and we need to re-implement the authentication endpoint anyway.
  # In APIs you don't use cookies and you don't have sessions.
  # Instead, when a user wants to sign in she sends an HTTP POST request
  # with her username and password to our API (in our case it's the sessions endpoint)
  # which sends back a token. This token is user's proof of who she is.
  # In each API request, rails finds the user based on the token sent.
  # If no user found with the received token the API should return a 401 error.
  def login
    account = Account.find_for_authentication(login: login_params[:login])
    if account && account.valid_password?(login_params[:password])
      if account.account_access_tokens.length < 4
        new_access_token = create_access_token(account)
        render(
            json: new_access_token.to_json,
            status: 201
        )
      else
        api_error(401, "Oh no")
      end
    else
      api_error(401)
    end

  end

  # Register a new push token .
  def register_push
    push_token = AccountPushToken.new(push_token_params)
    push_token.account = current_user
    if push_token.save
      render(
          #json: Api::V1::SessionSerializer.new(user, root: false).to_json,
          json: push_token.to_json,
          status: 201
      )
    else
       api_error(422, push_token.errors.details)
    end
  end

  # Register a new push token .
  def update_push

  end

  # Destroys a token
  # this may be triggered when the same devise is logged in
  def destroy
    @access_token.destroy
    render json: @access_token
  end

  private


  # Create a new success
  def create_access_token (account)
    token_value = SecureRandom.base64(64)
    access_token = AccountAccessToken.new(account: account,
                                          token_value: token_value,
                                          expires: DateTime.now + 30)
    # TODO , alert either the user will be connected using
    access_token.save!
    access_token
  end

  # Get prarams from header
  def access_params
    params.require(:account).permit([:login, :token])
  end

  # Get prarams from header
  def login_params
    params.require(:account).permit([:login, :password])
  end

  # Get prarams from header
  def push_token_params
    params.require(:push_token).permit([:value, :platform, :uuid])
  end

  # New user creation
  def register_params
    params.require(:account).permit([:username, :password, :confirm_password, :email, :age, :country])
  end
end
