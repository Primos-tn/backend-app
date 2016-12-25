require 'spec_helper'

describe "admin/categories/show" do
  before(:each) do
    @admin_category = assign(:admin_category, stub_model(Admin::Category))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
