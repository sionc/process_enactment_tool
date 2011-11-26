require 'spec_helper'
include Devise::TestHelpers

describe "users/show.html.erb" do
  before(:each) do
    @role = Factory.create(:role)
    @user = Factory.create(:user)
    sign_in @user
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Role/)
  end
end
