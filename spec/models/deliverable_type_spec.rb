require 'spec_helper'

describe DeliverableType do
  before(:each) do 
    lifecycle_phase = Factory.create(:lifecycle_phase)
    @attr = { :name => "test1", :lifecycle_phase_id => lifecycle_phase.id }
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
  
  it "should require a unique name" do
    valid_deliverable_type = DeliverableType.create!(@attr.merge(:name => "sameName"))
    valid_deliverable_type.should be_valid
    invalid_deliverable_type = DeliverableType.new(@attr.merge(:name => "sameName"))
    invalid_deliverable_type.should_not be_valid
  end
end
