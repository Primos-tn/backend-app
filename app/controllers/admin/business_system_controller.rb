class Admin::BusinessSystemController < Admin::BaseController

  def index
    configure
  end

  def configure
    @system = BusinessSystem.first_or_create
    render 'config'
  end


  def update

    @system = BusinessSystem.first_or_create
    form_config_params = config_params
=begin
    business_mails = form_config_params[:business_requests_mail_alert]
    crash_mails = form_config_params[:crash_mails_alert]
    account_expires_requests_mails = form_config_params[:account_expires_requests_mails_alert]
    contacts_mail_alert = form_config_params[:contacts_mail_alert]

    # check for business mails alerts
    if business_mails
      form_config_params[:business_requests_mail_alert] = business_mails.split('#')
    end

    # check for crash mails
    if crash_mails
      form_config_params[:crash_mails_alert] = crash_mails.split('#')
    end


    # check for business mails alerts
    if account_expires_requests_mails
      form_config_params[:account_expires_requests_mails_alert] = account_expires_requests_mails.split('#')

    end


    # check for business mails alerts
    if contacts_mail_alert
      form_config_params[:contacts_mail_alert] = contacts_mail_alert.split('#')
    end
=end
    @system.last_modified_by = current_user.id
    if @system.update(form_config_params)
      BusinessConfigurationChangeAlert.perform_later BusinessAlertsJob::UPDATE
      index
    end

  end
  protected

  def set_tab
    @active_tab = "business"
  end

end
