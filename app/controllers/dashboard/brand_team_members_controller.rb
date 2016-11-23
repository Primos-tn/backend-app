class Dashboard::BrandTeamMembersController < Dashboard::DashboardController
  # verify weather the user is a business account

  def index
    members = BrandTeamMember
                   .where({brand_id: current_brand.id})
    members_ids = members.map{|entry| entry.account_id}
    @members = Account.find(members_ids)
    current_user.is_brand_admin = true
    @members.append(current_user)
    @model = BrandTeamMember.new
    render 'index'

  end

  def set_admin

  end


  def invite
    if member_invite_params[:email]
       @email = member_invite_params[:email]
    end
    index
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_invite_params
    params.require(:member).permit(:email)
  end

  def set_tab
    @active_tab = 'team'
  end
end
