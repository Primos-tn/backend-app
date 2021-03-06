require 'spec_helper'

describe "invitations/edit" do
  before(:each) do
    @invitation = assign(:invitation, stub_model(Invitation,
      :user_id => 1,
      :to => "MyString",
      :source => "MyString"
    ))
  end

  it "renders the edit invitation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invitations_path(@invitation), :method => "post" do
      assert_select "input#invitation_user_id", :name => "invitation[user_id]"
      assert_select "input#invitation_to", :name => "invitation[to]"
      assert_select "input#invitation_source", :name => "invitation[source]"
    end
  end
end
