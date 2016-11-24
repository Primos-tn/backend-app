class Dashboard::ApiKeysController < Dashboard::DashboardController
  # define
  before_action :set_tab
  before_action :set_api_key

  def index
    @api_keys = current_user.apiKeys
  end


  def create
    # set valid  to month + 1
    @api_key.valide_to = Date.today().advance(:months => 1)
    @api_key.account = current_user
    @api_key.save
    respond_to do |format|
      format.html { redirect_to dashboard_api_keys_url, notice: 'Brand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # DELETE /api-keys/1
  # DELETE /api-keys/1.json
  def destroy
    api_key = ApiKey.find_by({:id => params[:id], :account => current_user})
    if api_key and api_key.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_api_keys_url, notice: 'Brand was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      index
    end
    # error
  end

  private

  def set_api_key
    @api_key = ApiKey.new
  end

  def set_tab
    @active_tab = 'api-keys'
  end
end
