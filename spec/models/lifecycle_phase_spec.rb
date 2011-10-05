require 'spec_helper'

describe LifecyclePhase do
  before(:each) do 
    lifecycle = Factory.create(:lifecycle)
    @attr = { :name => "test1", :lifecycle_id => lifecycle.id, :sequence_number => 1}
  end
  
  it "should create a new record given valid attributes" do
    LifecyclePhase.create!(@attr)
  end
  
  it "should require a lifecycle_id" do
    invalid_project = LifecyclePhase.new(@attr.merge(:lifecycle_id => nil))
    invalid_project.should_not be_valid
  end
  
end
