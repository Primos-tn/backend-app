class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_header
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def set_locale
    if params[:locale]
      # TODO check for supported locales
      cookies.permanent[:locale] = params[:locale]
    end
    I18n.locale = cookies.permanent[:locale] || 'en'
    cookies.permanent[:locale] = I18n.locale
  end

  def set_header
    @with_header = false
    @is_logged_in = user_signed_in?.present?
    @is_business = true if (@is_logged_in and current_user.is_business?)
  end


  def after_sign_in_path_for(resource)
    if current_user.is_admin?
      return admin_main_path
    elsif current_user.is_business?
      return dashboard_main_path
    end
    root_path
  end
end
