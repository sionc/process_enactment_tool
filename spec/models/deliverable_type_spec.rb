require 'spec_helper'

describe DeliverableType do
  before(:each) do 
    lifecycle_phase = Factory.create(:lifecycle_phase)
    unit_of_measure = Factory.create(:unit_of_measure)
    @attr = { :name => "test1",
              :lifecycle_phase_id => lifecycle_phase.id,
              :unit_of_measure_id => unit_of_measure.id}
  end
  
  it "should create a new record given valid attributes" do
    DeliverableType.create!(@attr)
  end
  
  it "should require a name" do
    invalid_deliverable_type = DeliverableType.new(@attr.merge(:name => nil))
    invalid_deliverable_type.should_not be_valid
  end
  
  it "should require a lifecycle_phase_id" do
    invalid_deliverable_type = DeliverableType.new(@attr.merge(:lifecycle_phase_id => nil))
    invalid_deliverable_type.should_not be_valid
  end

  it "should require a unit_of_measure_id" do
    invalid_deliverable_type = DeliverableType.new(@attr.merge(:unit_of_measure_id => nil))
    invalid_deliverable_type.should_not be_valid
  end

  #it "should require a unique name" do -- needs to be unique within a phase!
  #  valid_deliverable_type = DeliverableType.create!(@attr.merge(:name => "sameName"))
  #  valid_deliverable_type.should be_valid
  #  invalid_deliverable_type = DeliverableType.new(@attr.merge(:name => "sameName"))
  #  invalid_deliverable_type.should_not be_valid
  #end
end
