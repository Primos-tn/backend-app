class Account::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #
  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  def facebook

    if request.env['omniauth.auth'].info.email.blank?
      redirect_to '/accounts/auth/facebook?auth_type=rerequest&scope=email'
    end

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @account = Account.from_omniauth(request.env["omniauth.auth"])

    #
    if @account.persisted?
      sign_in_and_redirect @account, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end

  end


  # GET|POST /users/auth/twitter/callback
  def failure
    super
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
