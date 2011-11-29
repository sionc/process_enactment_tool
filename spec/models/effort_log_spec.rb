require 'spec_helper'

describe EffortLog do
  before(:each) do
    @deliverable = Factory.create(:deliverable)
    @curr_time = DateTime.now
    @attr = {:start_date_time => @curr_time - 2.hours,
             :stop_date_time => @curr_time,
             :interrupt_time => 15,
             :user_id => 1,
             :deliverable_id => @deliverable.id
    }
  end
  
  it "should create a new record given valid attributes" do
   EffortLog.create!(@attr)
  end

  it "should require start date time" do
   invalid_effort_log = EffortLog.new(@attr.merge(:start_date_time => nil))
   invalid_effort_log.should_not be_valid
  end
  
  it "should require stop date time" do
   invalid_effort_log = EffortLog.new(@attr.merge(:stop_date_time => nil))
   invalid_effort_log.should_not be_valid
  end
  
  it "should require a deliverable id" do
   invalid_effort_log = EffortLog.new(@attr.merge(:deliverable_id => nil))
   invalid_effort_log.should_not be_valid
  end
  
  it "should calculate the total effort" do
    effort_log = EffortLog.new(@attr)
    effort_log.logged_effort.should == 1.75
  end

  it "should not accept invalid start date time" do
    invalid_effort_log = EffortLog.new(@attr.merge(:start_date_time => "aaa?!+"))
    invalid_effort_log.should_not be_valid
  end

  it "should not accept invalid stop date time" do
    invalid_effort_log = EffortLog.new(@attr.merge(:stop_date_time => "aaa?!+"))
    invalid_effort_log.should_not be_valid
  end
  
  it "should not accept a start date that is after the end date" do
    invalid_effort_log = EffortLog.new(@attr.merge(:stop_date_time => @curr_time - 2, :start_date_time => @curr_time))
    invalid_effort_log.should_not be_valid
  end
  
  it "should not accept a start or stop date that is in the future (past midnight)" do
    invalid_effort_log = EffortLog.new(@attr.merge(:stop_date_time => DateTime.now.end_of_day + 1.minutes, :start_date_time => @curr_time))
    invalid_effort_log.should_not be_valid
  end
  
  it "should not accept an effort log that overlaps with a prior effort log" do
   EffortLog.create!(@attr)
   overlapping_effort_log = EffortLog.new(@attr)
   overlapping_effort_log.should_not be_valid
  end

end
