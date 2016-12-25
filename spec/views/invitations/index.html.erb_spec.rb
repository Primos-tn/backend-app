require 'spec_helper'

describe "invitations/index" do
  before(:each) do
    assign(:wait_lists, [
      stub_model(Invitation,
        :user_id => 1,
        :to => "To",
        :source => "Source"
      ),
      stub_model(Invitation,
        :user_id => 1,
        :to => "To",
        :source => "Source"
      )
    ])
  end

  it "renders a list of invitations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "To".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
  end
end
