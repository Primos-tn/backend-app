require 'spec_helper'

describe "invitations/show" do
  before(:each) do
    @invitation = assign(:invitation, stub_model(Invitation,
      :user_id => 1,
      :to => "To",
      :source => "Source"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/To/)
    rendered.should match(/Source/)
  end
end
