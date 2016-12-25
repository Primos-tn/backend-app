require 'spec_helper'

describe "requests/new" do
  before(:each) do
    assign(:request, stub_model(Request,
      :description => "MyString",
      :type => "",
      :sender_id => ""
    ).as_new_record)
  end

  it "renders new request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => requests_path, :method => "post" do
      assert_select "input#request_description", :name => "request[description]"
      assert_select "input#request_type", :name => "request[type]"
      assert_select "input#request_sender_id", :name => "request[sender_id]"
    end
  end
end
