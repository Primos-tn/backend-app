class Account::RegistrationsController < Devise::RegistrationsController
  before_filter :check_is_invited_and_confirmed, only: [:create]
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
# GET /resource/sign_up
# def new
#   super
# end

# POST /resource
# def create
#   super
# end

# GET /resource/edit
# def edit
#   super
# end

# PUT /resource
# def update
#   super
# end

# DELETE /resource
# def destroy
#   super
# end

# GET /resource/cancel
# Forces the session data which is usually expired after sign
# in to be expired now. This is useful if the user wants to
# cancel oauth signing in/up in the middle of the process,
# removing all OAuth session data.
# def cancel
#   super
# end

# protected

# If you have extra params to permit, append them to the sanitizer.
# def configure_sign_up_params
#   devise_parameter_sanitizer.for(:sign_up) << :attribute
# end

# If you have extra params to permit, append them to the sanitizer.
# def configure_account_update_params
#   devise_parameter_sanitizer.for(:account_update) << :attribute
# end

# The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
    AccountsMailer.welcome_user_and_validation(resource).deliver_later
    AccountsMailer.new_user_notify_system(resource).deliver_later
    redirect profile_path
  end

#
# Check if can create
#
  def check_is_invited_and_confirmed
    email = new_registration_params[:email]
    # check
    unless  email &&
        SystemConfiguration.first.with_invitation? &&
        AccountRegistrationInvitation.exists?(:email => email, :is_confirmed => true)
      redirect_to request_join_path + '?email=' + email
    end
  end

  def new_registration_params
    params.require(:user).permit(:email)
  end

# The path used after sign up for inactive accounts.
# def after_inactive_sign_up_path_for(resource)
#   super(resource)
# end
end
