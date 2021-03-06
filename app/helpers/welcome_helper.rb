module WelcomeHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= Account.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
