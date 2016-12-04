class Admin::SystemController < Admin::BaseController


  def index
    @system = SystemConfiguration.first
  end


  def update

  end

  protected

  def set_tab
    @active_tab = "system"
  end


end
