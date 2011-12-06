require 'spec_helper'

describe User do
  it "should return the user role" do
    @role = Factory.create(:role)
    @user = Factory.create(:user)
    @user.role.should eq("regular_user")
  end
  
  it "should return a set user role" do
    @role = Factory.create(:role)
    @user = Factory.create(:user)
    @user.role = @role.id
    @user.role.should eq("regular_user")
  end
  
  it "should return a user's role" do
    @role = Factory.create(:role)
    @user = Factory.create(:user)
    @user.role?(:regular_user).should be_true
  end
  
end
