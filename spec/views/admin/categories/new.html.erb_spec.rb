require 'spec_helper'

describe "admin/categories/new" do
  before(:each) do
    assign(:admin_category, stub_model(Admin::Category).as_new_record)
  end

  it "renders new admin_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_categories_path, :method => "post" do
    end
  end
end
