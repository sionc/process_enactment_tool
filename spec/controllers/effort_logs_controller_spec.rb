require 'spec_helper'
include Devise::TestHelpers

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe EffortLogsController do

  # This should return the minimal set of attributes required to create a valid
  # EffortLog. As you add validations to EffortLog, be sure to
  # update the return value of this method accordingly.
  
  before(:each) do
    @deliverable = Factory.create(:deliverable)
    @curr_time = Time.now
    @attr = {:start_date_time => @curr_time - 2.hours,
             :stop_date_time => @curr_time,
             :interrupt_time => 15,
             :user_id => 1,
             :deliverable_id => @deliverable.id
            }
    @user = Factory.create(:user)
    sign_in @user
  end
  

  describe "GET index" do
    it "assigns all effort_logs as @effort_logs" do
      effort_log = EffortLog.create! @attr.merge(:deliverable_id => @deliverable.id)
      get :index
      assigns(:effort_logs).should eq([effort_log])
    end
  end

  describe "GET show" do
    it "assigns the requested effort_log as @effort_log" do
      effort_log = EffortLog.create! @attr
      get :show, :id => effort_log.id
      assigns(:effort_log).should eq(effort_log)
    end
  end

  describe "GET new" do
    it "assigns a new effort_log as @effort_log" do
      get :new
      assigns(:effort_log).should be_a_new(EffortLog)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new EffortLog" do      
        expect {
          post :create, :effort_log => @attr.merge(:deliverable_id => @deliverable.id)
        }.to change(EffortLog, :count).by(1)
      end

      it "assigns a newly created effort_log as @effort_log" do        
        post :create, :effort_log => @attr.merge(:deliverable_id => @deliverable.id)
        assigns(:effort_log).should be_a(EffortLog)
        assigns(:effort_log).should be_persisted
      end

      it "redirects to the deliverable show page" do        
        post :create, :effort_log => @attr.merge(:deliverable_id => @deliverable.id)
        response.should redirect_to(@deliverable)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved effort_log as @effort_log" do
        # Trigger the behavior that occurs when invalid params are submitted
        EffortLog.any_instance.stub(:save).and_return(false)
        post :create, :effort_log => {}
        assigns(:effort_log).should be_a_new(EffortLog)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        EffortLog.any_instance.stub(:save).and_return(false)
        post :create, :effort_log => {}
        response.should render_template("new")
      end
    end
  end

end
