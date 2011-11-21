require 'spec_helper'

describe EffortLog do
  #stock_deliverable_type = Factory.create(:stock_deliverable_type)
  #complexity = Factory.create(:complexity)
  #@del_attr = {:name => "Effort Log Deliverable 2",
  #             :description => "This is the description of the deliverable",
  #             :estimated_size => 1.5,
  #             :estimated_production_rate => 2.5,
  #             :estimated_effort => 3.75,
  #             :assignable_id => stock_deliverable_type.id,
  #             :assignable_type => "StockDeliverableType",
  #             :complexity_id => complexity.id
  #}
  @deliverable = Factory.create(:deliverable)
  @attr = {:start_date_time => DateTime.now,
           :stop_date_time => DateTime.now,
           :interrupt_time => 15,
           :user_id => 1,
           :deliverable_id => @deliverable.id
  }

  #it "should create a new record given valid attributes" do
  #  EffortLog.create!(@attr)
  #end

  #it "should require start date time" do
  #  invalid_effort_log = EffortLog.new(@attr.merge(:start_date_time => nil))
  #  invalid_effort_log.should_not be_valid
  #end
  #
  #it "should require stop date time" do
  #  invalid_effort_log = EffortLog.new(@attr.merge(:stop_date_time => nil))
  #  invalid_effort_log.should_not be_valid
  #end
  #
  #it "should require a deliverable id" do
  #  invalid_effort_log = EffortLog.new(@attr.merge(:deliverable_id => nil))
  #  invalid_effort_log.should_not be_valid
  #end

end
