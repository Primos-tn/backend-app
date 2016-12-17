class Web::HomeController < Web::CompanyController
  before_filter :check_already_exists, only: [:request_join, :create_request_join]
  before_filter :set_full_template_page, only: [:request_join, :create_request_join, :request_pending]

  def index
  end

  def request_join
    @invitation = AccountRegistrationInvitation.new
  end

  def request_pending
    email = params[:email]
    if !email or !AccountRegistrationInvitation.exists?(:email => email, :is_confirmed => false)
      render file: 'public/400.html'
    end
  end

  def create_request_join
    @invitation = AccountRegistrationInvitation.new(invitation_params)
    email = @invitation.email
    if not Account.exists?(:email => email)

      # confirmed by the admin
      @invitation.is_confirmed = false
      @invitation.invitation_source = AccountRegistrationInvitation.invitation_sources[:request]
      if @invitation.save
        InvitationMailer.send_join_request_user(@invitation).deliver_now
        redirect_to root_path
      else
        @email = @invitation.email
      end

    else
      @invitation.errors.add(:base, t("Account is already exists !"))
    end

    render 'request_join'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def invitation_params
    params.require(:account_registration_invitation).permit(:first_name, :last_name, :email)
  end

  def check_already_exists
    email = params[:email]
    if email && AccountRegistrationInvitation.exists?(:email => email, :is_confirmed => false)
      redirect_to request_pending_path + '?email=' + email
    end
  end

  def set_full_template_page
    @full_template_page = true
  end

end
