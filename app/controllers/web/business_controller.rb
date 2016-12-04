class Web::BusinessController < Web::BaseController

  before_action :get_tags

  def index

  end

  def contact
    @contact = Contact.new(contact_params)
    @contact.save
    if @contact.save
      flash[:notice] = I18n.t('Success')
      flash[:notice_class] = 'success'
      ContactMailer.reply_contact(@contact.email).deliver_now
      redirect_to root_path
    end

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:email, :subject, :body)
  end

  private
  def get_tags
    @tags = Category.all()
  end
end
