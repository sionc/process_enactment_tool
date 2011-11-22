require 'spec_helper'

describe Project do
  before(:each) do 
    @lifecycle = Factory.create(:lifecycle)
    @attr = { :name => "test1", :lifecycle_id => @lifecycle.id}
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
  
  it "should calculate the total logged effort" do 
    valid_project = Project.create!(@attr)  
    lifecycle_phase_1 = Factory.create(:lifecycle_phase, :name => "phase 1", 
                                       :lifecycle_id => @lifecycle.id, 
                                       :sequence_number => 1)  
    lifecycle_phase_2 = Factory.create(:lifecycle_phase, 
                                       :name => "phase 2", 
                                       :lifecycle_id => @lifecycle.id, 
                                       :sequence_number => 2)  
    
    
    
    valid_phase_1 = Factory.create(:project_phase, 
                                   :project_id => valid_project.id, 
                                   :lifecycle_phase_id => lifecycle_phase_1.id)
    stock_deliverable_type_1 = Factory.create(:stock_deliverable_type, :project_phase_id => valid_phase_1.id)
    valid_deliverable_1 = Factory.create(:deliverable, 
                                         :assignable_id => stock_deliverable_type_1.id, 
                                         :assignable_type => "StockDeliverableType")
    Factory.create(:effort_log, :deliverable_id => valid_deliverable_1.id)
    Factory.create(:effort_log, :deliverable_id => valid_deliverable_1.id, :interrupt_time => 30)

    valid_deliverable_2 = Factory.create(:deliverable, 
                                         :assignable_id => stock_deliverable_type_1.id, 
                                         :assignable_type => "StockDeliverableType")
    Factory.create(:effort_log, :deliverable_id => valid_deliverable_2.id)
    Factory.create(:effort_log, :deliverable_id => valid_deliverable_2.id, :interrupt_time => 30)


    valid_phase_2 = Factory.create(:project_phase, 
                                   :project_id => valid_project.id, 
                                   :lifecycle_phase_id => lifecycle_phase_2.id)
    stock_deliverable_type_2 = Factory.create(:stock_deliverable_type, :project_phase_id => valid_phase_2.id)
    valid_deliverable_3 = Factory.create(:deliverable, 
                                         :assignable_id => stock_deliverable_type_2.id, 
                                         :assignable_type => "StockDeliverableType")
    Factory.create(:effort_log, :deliverable_id => valid_deliverable_3.id)
    Factory.create(:effort_log, :deliverable_id => valid_deliverable_3.id, :interrupt_time => 30)

    valid_deliverable_4 = Factory.create(:deliverable, 
                                         :assignable_id => stock_deliverable_type_2.id, 
                                         :assignable_type => "StockDeliverableType")
    Factory.create(:effort_log, :deliverable_id => valid_deliverable_4.id)
    Factory.create(:effort_log, :deliverable_id => valid_deliverable_4.id, :interrupt_time => 30)

    

    valid_project.logged_effort.should == 13.0
  end
  
  
  
  
end