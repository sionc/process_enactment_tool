require 'spec_helper'

describe StockDeliverableType do
  before(:each) do
    deliverable_type = Factory.create(:deliverable_type)
    project_phase = Factory.create(:project_phase)
    @attr = { :deliverable_type_id => deliverable_type.id,
              :project_phase_id => project_phase.id
    }
  end

  it "should create a new record given valid attributes" do
     StockDeliverableType.create!(@attr)
   end

  it "should require a deliverable type" do
   invalid_stock_deliverable_type = StockDeliverableType.new(@attr.merge(:deliverable_type_id => nil))
   invalid_stock_deliverable_type.should_not be_valid
  end

   it "should require a project phase" do
   invalid_stock_deliverable_type = StockDeliverableType.new(@attr.merge(:project_phase_id => nil))
   invalid_stock_deliverable_type.should_not be_valid
  end

end
