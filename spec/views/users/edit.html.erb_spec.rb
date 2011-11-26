require 'spec_helper'
include Devise::TestHelpers

describe "users/edit.html.erb" do
  before(:each) do
    role = Factory.create(:role)
    @roles = [role]
    @user = Factory.create(:user)
    sign_in @user
  end
  

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => user_path(@user), :method => "post" do
      assert_select "input#user_email", :name => "user[email]"
    end
  end
end
