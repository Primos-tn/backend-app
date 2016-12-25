require 'spec_helper'

describe "admin/categories/edit" do
  before(:each) do
    @admin_category = assign(:admin_category, stub_model(Admin::Category))
  end

  it "renders the edit admin_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_categories_path(@admin_category), :method => "post" do
    end
  end
end
