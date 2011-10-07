require 'spec_helper'

describe "Deliverables" do
  describe "GET /deliverables" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      stock_deliverable_type = Factory.create(:stock_deliverable_type)
      get deliverables_path, :stock_deliverable_type_id => stock_deliverable_type.id
      response.status.should be(200)
    end
  end
end
