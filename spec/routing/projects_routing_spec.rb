require "spec_helper"

describe ProjectsController do
  describe "routing" do

    it "routes to #index" do
      get("/projects").should route_to("projects#index")
      {:get => "/projects"}.should be_routable
    end

    it "routes to #new" do
      get("/projects/new").should route_to("projects#new")
    end

    it "routes to #show" do
      get("/projects/1").should route_to("projects#show", :id => "1")
    end

    it "should not route to #edit" do
      {:get => "/projects/1/edit"}.should_not be_routable
    end

    it "routes to #create" do
      post("/projects").should route_to("projects#create")
    end

    it "should not route to #update" do
      {:put => "/projects/1"}.should_not be_routable
    end

    it "should not route to #destroy" do
      {:delete => "/projects/1"}.should_not be_routable
    end

  end
end
