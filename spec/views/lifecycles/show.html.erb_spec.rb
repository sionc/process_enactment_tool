require 'spec_helper'
include Devise::TestHelpers

describe "lifecycles/show.html.erb" do
  before(:each) do
    @role = Factory.create(:role)
    @admin_role = Factory.create(:admin_role)
    @admin_user = Factory.create(:admin_user)
    @admin_user.roles = [@admin_role]
    sign_in @admin_user
    @current_user = @admin_user

    @lifecycle = assign(:lifecycle, stub_model(Lifecycle,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end

  it "should have a 'Create Lifecyle Phase' button" do
    render
    rendered.should match(/Create Lifecycle Phase/)
   end

  it "should not have a 'Create Lifecyle Phase' button if lifecycle has projects" do
    Factory.create(:project, :lifecycle_id => @lifecycle.id)
    render
    rendered.should_not match(/Create Lifecycle Phase/)
  end

end
