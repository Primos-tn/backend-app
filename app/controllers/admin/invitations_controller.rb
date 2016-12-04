class Admin::InvitationsController < Admin::BaseController
  # GET /accounts
  # GET /accounts.json
  def index
    page = params[:page]
    limit = params[:limit] || 10

    if page.nil?
      page = 1
    else
      page = [page.to_i, 1].max
    end
    sort_column = params[:sort] || ''
    sort_direction = params[:direction] || ''
    @invitations = AccountRegistrationInvitation
                       .search(params[:search])
                       .order(sort_column + ' ' + sort_direction)
                       .page(page)
                       .per(limit)
  end

  def new
    @invitation = AccountRegistrationInvitation.new
  end


  # POST /brands
  # POST /brands.json
  def create

    @invitation = AccountRegistrationInvitation.new(invitation_params)
    @invitation.sender = current_user
    respond_to do |format|
      if @invitation.save
        InvitationMailer.invite_user(@invitation).deliver_now
        format.html { redirect_to admin_invitations_url(@invitation),
                                  notice: I18n.t('Invitation has been sent was successfully created.') }
        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end

  end


  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    respond_to do |format|
      if @invitation.update(brand_params)
        @invitation.save!
        format.html { redirect_to admin_accounts_registrations_invitations, notice: I18n.t('Invitation was successfully updated.') }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render json: @invitation.errors, status: :unprocessable_entity }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    if @invitation.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_brands_url, notice: I18n.t('Brand was successfully destroyed.') }
        format.json { head :no_content }
      end
    end
  end

  protected

  def set_tab
    @active_tab = 'invitations'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_invitation
    @invitation = AccountRegistrationInvitation.find(params[:id])
  end


  # Use callbacks to share common setup or constraints between actions.
  def invitation_params
    params.require(:account_registration_invitation).permit(:first_name, :last_name, :email)
  end
end
