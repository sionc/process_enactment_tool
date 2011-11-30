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
    effort_log_1 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_1.id)
    effort_log_2 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_1.id, 
                                               :start_date_time => effort_log_1.stop_date_time,
                                               :stop_date_time => effort_log_1.stop_date_time + 2.hours,
                                               :interrupt_time => 30)

    valid_deliverable_2 = Factory.create(:deliverable, 
                                         :assignable_id => stock_deliverable_type_1.id, 
                                         :assignable_type => "StockDeliverableType")
    effort_log_3 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_2.id, 
                                               :start_date_time => effort_log_2.stop_date_time,
                                               :stop_date_time => effort_log_2.stop_date_time + 2.hours)
    effort_log_4 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_2.id, 
                                               :start_date_time => effort_log_3.stop_date_time, 
                                               :stop_date_time => effort_log_3.stop_date_time + 2.hours,
                                               :interrupt_time => 30)


    valid_phase_2 = Factory.create(:project_phase, 
                                   :project_id => valid_project.id, 
                                   :lifecycle_phase_id => lifecycle_phase_2.id)
    stock_deliverable_type_2 = Factory.create(:stock_deliverable_type, :project_phase_id => valid_phase_2.id)
    valid_deliverable_3 = Factory.create(:deliverable, 
                                         :assignable_id => stock_deliverable_type_2.id, 
                                         :assignable_type => "StockDeliverableType")
    effort_log_5 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_3.id, 
                                               :start_date_time => effort_log_4.stop_date_time, 
                                               :stop_date_time => effort_log_4.stop_date_time + 2.hours)
    effort_log_6 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_3.id, 
                                               :start_date_time => effort_log_5.stop_date_time, 
                                               :stop_date_time => effort_log_5.stop_date_time + 2.hours, 
                                               :interrupt_time => 30)

    valid_deliverable_4 = Factory.create(:deliverable, 
                                         :assignable_id => stock_deliverable_type_2.id, 
                                         :assignable_type => "StockDeliverableType")
    effort_log_7 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_4.id, 
                                               :start_date_time => effort_log_6.stop_date_time, 
                                               :stop_date_time => effort_log_6.stop_date_time + 2.hours)
    effort_log_8 = Factory.create(:effort_log, :deliverable_id => valid_deliverable_4.id, 
                                               :start_date_time => effort_log_7.stop_date_time, 
                                               :stop_date_time => effort_log_7.stop_date_time + 2.hours, 
                                               :interrupt_time => 30)

    

    valid_project.logged_effort.should == 13.0
  end
  
  
  
  
end