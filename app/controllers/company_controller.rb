class CompanyController < ApplicationController
  def show
    page = params[:page]
    if page == "about"
      render  "company/about", layout: false
      else
      render "company/#{page}"
    end
  end
  def contact
  end
end
