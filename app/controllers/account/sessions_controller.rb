class Account::SessionsController < Devise::SessionsController
  before_filter :check_is_invited_and_confirmed, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
  private

  def check_is_invited_and_confirmed
    email = new_session_params[:email]
    # check
    if SystemConfiguration.first.with_invitation? && !Account.exists?(:email => email)
      # check for admin
      if email && AccountRegistrationInvitation.exists?(:email => email, :is_confirmed => false)
        redirect_to request_pending_path + '?email=' + email
      end

      if email && !AccountRegistrationInvitation.exists?(:email => email, :is_confirmed => true )
        redirect_to request_join_path + '?email=' + email
      end
    end
  end

  def new_session_params
    params.require(:user).permit(:email)

  end

end
