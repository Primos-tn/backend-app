class WelcomeController < ApplicationController
  def index ()
    render 'company/about', layout: false
  end
end
