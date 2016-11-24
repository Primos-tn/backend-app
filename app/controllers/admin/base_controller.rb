class Admin::BaseController < ApplicationController
  # define layout
  layout 'admin'
  # verify if  the user is a admin
  before_filter :is_admin

  def index
    @total_brands = Brand.count
    @total_accounts = Account.count
    @total_categories = Category.count
    render 'admin/index'
  end


  def is_admin
    unless current_user and current_user.is_admin?
      redirect_to new_user_session_path
    end
  end
end
