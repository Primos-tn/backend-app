class Admin::AjaxController < ApplicationController

  def info
    @business_pending_count = BusinessProfile.where(:pending => true).count
    @invitations_pending_count = AccountRegistrationInvitation.where(:is_confirmed => false).count
    @business_accounts_count =  BusinessProfile.count
    @brands_count =  Brand.count
  end

end
