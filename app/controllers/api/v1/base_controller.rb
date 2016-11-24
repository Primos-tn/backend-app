class Api::V1::BaseController < ApplicationController
  # turn forgery off
  protect_from_forgery with: :null_session
  # raise all non found record to be catched by not_found method
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # destroy action
  before_action :destroy_session
  before_filter :authenticate_user!

  # destroy current session
  def destroy_session
    request.session_options[:skip] = true
  end

  # handle RecordNotFound exception
  def not_found
    api_error(404, 'Not found')
  end

  # api error pretty
  def api_error(status = 500, errors = [], action = 'IDLE')
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: json_api_format(errors, action), status: status
  end

  # Once the client has the token it sends both token and email
  # to the API for each subsequent request.
  def authenticate_user!
    #FIXME , please filter your source
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


  def reply_success (message)
    render json: {:response => message}, status: 200
  end


  def reply_error (error)
    render json: {:response => {:error => error}}, status: 500
  end

  #ember specific :/
  def json_api_format(errors, action=nil)
    errors_hash = {}
    if errors.is_a? Array

      errors_hash['errors'] = errors
    else
      if errors.is_a? String
        errors_hash['error'] = errors
      else
        errors.messages.each do |attribute, error|
          array_hash = []
          error.each do |e|
            array_hash << {attribute: attribute, message: e}
          end
          errors_hash.merge!({attribute => array_hash})
        end

      end
    end

    unless action.nil?
      errors_hash['action'] = action
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
    api_error(401, 'Not authorized', 'LOGIN')
  end

end
