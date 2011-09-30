require 'spec_helper'

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

describe ProjectsController do

  # This should return the minimal set of attributes required to create a valid
  # Project. As you add validations to Project, be sure to
  # update the return value of this method accordingly.
  before(:each) do
    lifecycle = Factory.create(:lifecycle)
    @attr = { :name => "test1", :lifecycle_id => lifecycle.id }
  end

  describe "GET index" do
    it "assigns all projects as @projects" do
      project = Project.create!(@attr)
      get :index
      assigns(:projects).should eq([project])
    end
    
    it "should be accessible" do      
      {:get => 'projects/index'}.should be_routable      
    end
  end

  describe "GET show" do
    it "assigns the requested project as @project" do
      project = Project.create!(@attr)
      get :show, :id => project.id.to_s
      assigns(:project).should eq(project)
    end
  end
  


  describe "GET new" do
    it "assigns a new project as @project" do
      get :new
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "GET edit" do
    it "should not be valid" do
      {:get => :edit}.should_not be_routable
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, :project => @attr
        }.to change(Project, :count).by(1)
      end

      it "assigns a newly created project as @project" do
        post :create, :project => @attr
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end

      it "redirects to the created project" do
        post :create, :project => @attr
        response.should redirect_to(Project.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, :project => {}
        assigns(:project).should be_a_new(Project)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, :project => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    it "should not be accessible" do
      project = Project.create! @attr
      {:put => :update, :id => project.id, :project => @attr}.should_not be_routable
    end
  end

  describe "DELETE destroy" do
    it "should not be accessible" do
      project = Project.create! @attr
      {:delete => :destroy, :id => project.id.to_s}.should_not be_routable
    end
  end

end
