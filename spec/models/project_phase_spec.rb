require 'spec_helper'

describe ProjectPhase do
  before(:each) do 
    lifecycle_phase = Factory.create(:lifecycle_phase)
    project = Factory.create(:project)
    @attr = { :lifecycle_phase_id => lifecycle_phase.id, :project_id => project.id } 
  end
  
  it "should create a new record given valid attributes" do
    ProjectPhase.create!(@attr)
  end
  
  it "should require a lifecycle_phase_id" do
    invalid_project = ProjectPhase.new(@attr.merge(:lifecycle_phase_id => nil))
    invalid_project.should_not be_valid
  end
  
  it "should require a project_id" do
    invalid_project = ProjectPhase.new(@attr.merge(:project_id => nil))
    invalid_project.should_not be_valid
  end
  
end
