require 'spec_helper'

describe StockDeliverableType do
  before(:each) do

    stock_deliverable_type = Factory.create(:stock_deliverable_type)
    deliverable_type = stock_deliverable_type.deliverable_type #Factory.create(:deliverable_type)
    project_phase = stock_deliverable_type.project_phase #Factory.create(:project_phase)
    @attr = { :deliverable_type_id => deliverable_type.id,
              :project_phase_id => project_phase.id
    }




    @del1 = Factory(:deliverable,
                    :assignable_id => stock_deliverable_type.id,
                    :assignable_type => "StockDeliverableType",
                    :estimated_size => 1,
                    :estimated_production_rate => 2,
                    :estimated_effort => 2)

    @del2 = Factory(:deliverable,
                    :assignable_id => stock_deliverable_type.id,
                    :assignable_type => "StockDeliverableType",
                    :estimated_size => 2 ,
                    :estimated_production_rate => 4,
                    :estimated_effort => 8)

    @del3 = Factory(:deliverable,
                    :assignable_id => stock_deliverable_type.id,
                    :assignable_type => "StockDeliverableType",
                    :estimated_size => 3,
                    :estimated_production_rate => 6,
                    :estimated_effort => 18)
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

  it "should return the StockDeliverableType deliverable with minimum estimated effort for complexity type of low" do
    minimum_deliverable = StockDeliverableType.minimum_estimated_effort("low")
    minimum_deliverable.should eql?(@del1)
  end

end
