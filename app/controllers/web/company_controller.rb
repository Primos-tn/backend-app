class Web::CompanyController < Web::BaseController

  before_action :get_tags


  def show
    page = params[:page]
    if page == 'pluto' then
      render "#{page}", :layout => false
    else
      render "#{page}"
    end

  end

  def contact_business
    email = params[:email]
    if Contact.exists?(:email => email) then
      flash[:notice] = "Email already created !"
      flash[:notice_class] = "error"
      render :template => 'company/business'
    else
      flash[:notice] = "Pingo, we will be in touch soonly !"
      flash[:notice_class] = "success"
      comer = Contact.new
      comer.email = params[:email]
      comer.body = params[:body]
      comer.type = "business"
      comer.save
      BusinessContactMailer.reply_invitation(comer.email).deliver_now
    end
  end

  def contact
  end

  private
  def get_tags
    @tags = Category.all()
  end
end
