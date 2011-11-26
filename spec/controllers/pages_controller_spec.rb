require 'spec_helper'
include Devise::TestHelpers

describe PagesController do
  before(:each) do
     @role = Factory.create(:role)
     @user = Factory.create(:user)
     sign_in @user
   end
end
