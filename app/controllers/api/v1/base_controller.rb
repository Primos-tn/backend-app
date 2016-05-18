class Api::V1::BaseController < ApplicationController
  # turn forgery off
  protect_from_forgery with: :null_session
  # raise all non found record to be catched by not_found method
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # destroy action
  before_action :destroy_session

  # destroy current session
  def destroy_session
    request.session_options[:skip] = true
  end

  # handle RecordNotFound exception
  def not_found
    api_error(status: 404, errors: 'Not found')
  end

  # api error pretty
  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: jsonapi_format(errors).to_json, status: status
  end

  # Once the client has the token it sends both token and email
  # to the API for each subsequent request.
  def authenticate_user!
    #FIXME ,  plase filter your source
    if current_user
      return current_user
    end
    # get token and options
    options = create_authentication_params
    user_email = options[:email]
    token = options[:token]
    print "token is #{token}>>> \n"
    user = user_email && Account.find_by(email: user_email)
    access_token = user && AccessToken.find_by(value: token, account: user)
    # check if user exists and
    if user && access_token
      logger.info user
      print "access token is >>> \n"
      print access_token
      @access_token = access_token
      @current_user = user
    else
      unauthenticated!
    end
  end

  #ember specific :/
  def jsonapi_format(errors)
    return errors if errors.is_a? String
    errors_hash = {}
    errors.messages.each do |attribute, error|
      array_hash = []
      error.each do |e|
        array_hash << {attribute: attribute, message: e}
      end
      errors_hash.merge!({attribute => array_hash})
    end

    errors_hash
  end

  private

  # extract params , we need token and email
  def create_authentication_params
    params.permit([:email, :token])
  end

  protected
  #
  # Not authorized application
  #
  def unauthenticated!
    api_error(status: 401, errors: 'Not authorized')
  end


end
