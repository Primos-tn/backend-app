class Web::WelcomeController < ApplicationController
  def index
    render 'company/about'
  end
end
