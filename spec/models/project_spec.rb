require 'spec_helper'

describe Project do
  before(:each) do 
    lifecycle = Factory.create(:lifecycle)
    @attr = { :name => "test1", :lifecycle_id => lifecycle.id}
  end
  
  it "should create a new record given valid attributes" do
    Project.create!(@attr)
  end
  
  it "should require a name" do
    invalid_project = Project.new(@attr.merge(:name => nil))
    invalid_project.should_not be_valid
  end
  
  it "should require a lifecycle_id" do
    invalid_project = Project.new(@attr.merge(:lifecycle_id => nil))
    invalid_project.should_not be_valid
  end
  
  it "should require a unique name" do
    valid_project = Project.create!(@attr.merge(:name => "sameName"))
    valid_project.should be_valid
    invalid_project = Project.new(@attr.merge(:name => "sameName"))
    invalid_project.should_not be_valid
  end
  
end