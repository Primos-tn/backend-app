require 'spec_helper'

describe "admin/categories/index" do
  before(:each) do
    assign(:admin_categories, [
      stub_model(Admin::Category),
      stub_model(Admin::Category)
    ])
  end

  it "renders a list of admin/categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
