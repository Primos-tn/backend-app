class Web::EngineeringController < Web::BaseController
  before_action :set_full_page

  def index
    page = params[:page] || 'index'
    render file: "public/engineering/#{page}.html.erb", template: true
  end

  private
  def set_full_page
    @full_template_page = true
  end
end
