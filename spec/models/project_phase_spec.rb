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
  
  it "should calculate the total logged effort" do     
    valid_phase = ProjectPhase.create!(@attr)
    stock_deliverable_type = Factory.create(:stock_deliverable_type, :project_phase_id => valid_phase.id)
    valid_deliverable_1 = Factory.create(:deliverable, 
                                         :assignable_id => stock_deliverable_type.id, 
                                         :assignable_type => "StockDeliverableType")
    effort_log_1 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_1.id)
    effort_log_2 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_1.id, :interrupt_time => 30)

    valid_deliverable_2 = Factory.create(:deliverable, 
                                         :assignable_id => stock_deliverable_type.id, 
                                         :assignable_type => "StockDeliverableType")
    effort_log_3 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_2.id)
    effort_log_4 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_2.id, :interrupt_time => 30)

    valid_phase.logged_effort.should == 6.5
  end
  
end
