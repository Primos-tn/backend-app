class Web::BusinessController < Web::BaseController
  before_action :authenticate_user!, :only => [:create_request_account]

  def index
    if current_user && current_user.business_profile && !current_user.business_profile.is_confirmed
      render 'request_pending'
    end
  end


  def request_account
    @business = BusinessProfile.new
  end


  def create_request_account
    if BusinessProfile.where(account: current_user).exists?
      render 'request_pending'
    else
      business_profile = BusinessProfile.new(business_profile_params)
      business_profile.account = current_user
      if business_profile.save
        # change me deliver later
        BusinessMailer.new_business_request(current_user, business_profile).deliver_now
        AdminMailer.new_business_request(business_profile).deliver_now
        flash[:notice] = t('Sucess')
        redirect_to root
      end
      @business = business_profile
      render 'request_account'
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def business_profile_params
    params.require(:business_profile).permit(:company_name, :business_phone, :business_email, :country, :post_code, :city, :company_address)
  end

end
