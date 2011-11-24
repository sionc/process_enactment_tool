require 'spec_helper'
include Devise::TestHelpers

describe ProjectPhasesController do
  before(:each) do
     @user = Factory.create(:user)
     sign_in @user
   end

end
