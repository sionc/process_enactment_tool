require 'spec_helper'
include Devise::TestHelpers

describe LifecyclePhasesController do

   before(:each) do
    @role = Factory.create(:role)
    @admin_role = Factory.create(:admin_role)
    @admin_user = Factory.create(:admin_user)
    @admin_user.roles = [@admin_role]
    sign_in @admin_user

    @lifecycle = Factory.create(:lifecycle)
  end
  # method for getting only the valid attributes
  def valid_attributes
    {:name => "Test Lifecycle Phase",
     :sequence_number => 1,
     :lifecycle_id => @lifecycle.id}
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', :lifecycle_id => @lifecycle.id
      response.should be_success
    end

    it "assigns a new lifecycle_phase as @lifecycle_phase" do
      get :new, :lifecycle_id => @lifecycle.id
      assigns(:lifecycle_phase).should be_a_new(LifecyclePhase)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new LifecyclePhase" do
        expect {
          post :create, :lifecycle_phase => valid_attributes
        }.to change(LifecyclePhase, :count).by(1)
      end

      it "assigns a newly created lifecycle phase as @lifecycle_phase" do
        post :create, :lifecycle_phase => valid_attributes
        assigns(:lifecycle_phase).should be_a(LifecyclePhase)
        assigns(:lifecycle_phase).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved lifecycle phase as @lifecycle_phase" do
        # Trigger the behavior that occurs when invalid params are submitted
        LifecyclePhase.any_instance.stub(:save).and_return(false)
        post :create, :lifecycle_phase => {:lifecycle_id => @lifecycle.id}
        assigns(:lifecycle_phase).should be_a_new(LifecyclePhase)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        LifecyclePhase.any_instance.stub(:save).and_return(false)
        post :create, :lifecycle_phase => {:lifecycle_id => @lifecycle.id}
        response.should render_template("new")
      end
    end
  end
  
  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "should update the sequence numbers of the phases" do
  #       post :update, :lifecycle_phase => {:lifecycle_id => @lifecycle.id}
  #       @lifecycle.lifecyle_phases.first.sequence_number.should eq(2)
  #     end
  #   end
  # end

end
