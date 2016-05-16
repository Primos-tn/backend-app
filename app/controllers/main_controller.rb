class MainController < ApplicationController
  # GET /
  # GET /
  def index
      @articles = Article.all
  end
end
