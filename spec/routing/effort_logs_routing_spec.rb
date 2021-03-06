require "spec_helper"

describe EffortLogsController do
  describe "routing" do
    it "routes to #new" do
      get("/effort_logs/new").should route_to("effort_logs#new")
    end

    it "routes to #show" do
      get("/effort_logs/1").should route_to("effort_logs#show", :id => "1")
    end

    it "routes to #create" do
      post("/effort_logs").should route_to("effort_logs#create")
    end
  end
end
