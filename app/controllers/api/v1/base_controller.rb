class Api::V1::BaseController < ApplicationController
  # turn forgery off
  protect_from_forgery with: :null_session
  # raise all non found record to be catched by not_found method
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # destroy action
  before_action :check_for_token
  before_action :destroy_session
  before_action :authenticate_user!, except: [:not_found]

  # destroy current session
  def destroy_session
    request.session_options[:skip] = true
  end

  # handle RecordNotFound exception
  def not_found(error='Not found')
    api_error(404, error)
  end

  # api error pretty
  def api_error(status = 500, errors = [], action = 'IDLE')
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head(status: status) and return if errors.empty?
    render json: json_api_format(errors, action), status: status
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
      errors_hash[:error] = errors
    else
      if errors.is_a? String
        errors_hash[:error] = errors
      else
        if errors.has_key?(:message)
          errors_hash[:error] = errors
        else
          if errors.has_key?(:messages)
            errors.messages.each do |attribute, error|
              array_hash = []
              error.each do |e|
                array_hash << {attribute: attribute, message: e}
              end
              errors_hash.merge!({attribute => array_hash})
            end
          else
            errors_hash[:error] = errors
          end

        end
      end
    end

    unless action.nil?
      errors_hash['action'] = action
    end

    errors_hash
  end


  private


  protected
  #
  # Next function
  #
  def next!
    render json: {:reason => 'next version'}, status: 401
  end

  #
  # Not authorized application
  #
  def unauthenticated!
    api_error(401, 'Not authorized', 'LOGIN')
  end

  # def request_http_token_authentication(realm = "Application", message='HTTP Token: Access denied. You did not provide an valid API key.')
  #   self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, '')}")
  #   unauthenticated!
  # end

  # Once the client has the token it sends both token and email
  # to the API for each subsequent request.
  def authenticate_user!
    return true if @current_user
    # get token and options
    authenticate_or_request_with_http_token do |token, options|
      access_token = AccountAccessToken.where('token_value = ? AND expires > ?', token, Date.today).first
      if access_token
        sign_in access_token.account
      else
        unauthenticated!
      end
    end
  end

  # Check if the user has an authorization in the header
  def check_for_token
    if request.authorization
      authenticate_user!
    end
  end

end
