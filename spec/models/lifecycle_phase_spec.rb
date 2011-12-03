require 'spec_helper'

describe LifecyclePhase do
  before(:each) do 
    lifecycle = Factory.create(:lifecycle)
    @attr = { :name => "test lifecycle phase", :lifecycle_id => lifecycle.id, :sequence_number => 1}
  end
  
  it "should create a new record given valid attributes" do
    LifecyclePhase.create!(@attr)
  end
  
  it "should require a lifecycle_id" do
    invalid_lifecycle_phase = LifecyclePhase.new(@attr.merge(:lifecycle_id => nil))
    invalid_lifecycle_phase.should_not be_valid
  end

  it "should require a name" do
    invalid_lifecycle_phase = LifecyclePhase.new(@attr.merge(:name => nil))
    invalid_lifecycle_phase.should_not be_valid
  end

  it "should require a sequence number" do
    invalid_lifecycle_phase = LifecyclePhase.new(@attr.merge(:sequence_number => nil))
    invalid_lifecycle_phase.should_not be_valid
  end

  it "should require a unique sequence number" do
    LifecyclePhase.create!(@attr)
    invalid_lifecycle_phase =  LifecyclePhase.new(@attr.merge(:sequence_number => 1))
    invalid_lifecycle_phase.should_not be_valid
  end

  it "should require a sequence number that does not exceed number of lifecycle phases" do
    invalid_lifecycle_phase =  LifecyclePhase.new(@attr.merge(:sequence_number => 3))
    invalid_lifecycle_phase.should_not be_valid
  end

end
