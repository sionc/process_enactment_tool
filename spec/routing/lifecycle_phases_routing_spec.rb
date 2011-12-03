require "spec_helper"

describe LifecyclePhasesController do
  describe "routing" do

    it "routes to #new" do
         get("/lifecycle_phases/new").should route_to("lifecycle_phases#new")
    end

    it "routes to #create" do
      post("/lifecycle_phases").should route_to("lifecycle_phases#create")
    end

    it "routes to #update" do
      put("/lifecycle_phases/1").should route_to("lifecycle_phases#update", :id => "1")
    end

  end
end
