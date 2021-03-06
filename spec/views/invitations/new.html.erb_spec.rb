require 'spec_helper'

describe "invitations/new" do
  before(:each) do
    assign(:invitation, stub_model(Invitation,
      :user_id => 1,
      :to => "MyString",
      :source => "MyString"
    ).as_new_record)
  end

  it "renders new invitation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invitations_path, :method => "post" do
      assert_select "input#invitation_user_id", :name => "invitation[user_id]"
      assert_select "input#invitation_to", :name => "invitation[to]"
      assert_select "input#invitation_source", :name => "invitation[source]"
    end
  end
end
