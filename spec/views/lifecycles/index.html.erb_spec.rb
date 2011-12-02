require 'spec_helper'
include Devise::TestHelpers

describe "lifecycles/index.html.erb" do
  before(:each) do
    @role = Factory.create(:role)
    @admin_role = Factory.create(:admin_role)
    @admin_user = Factory.create(:admin_user)
    @admin_user.roles = [@admin_role]
    sign_in @admin_user
    @current_user = @admin_user

    assign(:lifecycles, [
      stub_model(Lifecycle,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(Lifecycle,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of lifecycles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end

  it "should have a 'Create Lifecyle' button" do
    render
    rendered.should match(/Create Lifecycle/)
  end
end
