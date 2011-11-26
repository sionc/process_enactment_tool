require 'spec_helper'
include Devise::TestHelpers

describe "users/index.html.erb" do
  before(:each) do
    Factory.create(:role)    
    user_1 = Factory.create(:user, :email => "test_1@test.com")
    user_2 = Factory.create(:user, :email => "test_2@test.com")
    @users = [user_1, user_2]
    sign_in @users.first
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "test_1@test.com".to_s, :count => 1
  end
end
