require 'spec_helper'

describe Deliverable do
  before(:each) do
    stock_deliverable_type = Factory.create(:stock_deliverable_type)
    complexity = Factory.create(:complexity)
    @attr = { :name => "test deliverable",
              :description => "This is the description of the deliverable",
              :estimated_size => 1.5 ,
              :estimated_production_rate => 2.5 ,
              :estimated_effort => 3.75 ,
              :assignable_id => stock_deliverable_type.id,
              :assignable_type => "StockDeliverableType",
              :complexity_id => complexity.id
    }
  end

  it "should create a new record given valid attributes" do
    Deliverable.create!(@attr)
  end

   it "should require a name" do
    invalid_deliverable = Deliverable.new(@attr.merge(:name => nil))
    invalid_deliverable.should_not be_valid
   end

  it "should require a assignable_id" do
    invalid_deliverable = Deliverable.new(@attr.merge(:assignable_id => nil))
    invalid_deliverable.should_not be_valid
  end

  it "should require a assignable_type" do
    invalid_deliverable = Deliverable.new(@attr.merge(:assignable_type => nil))
    invalid_deliverable.should_not be_valid
  end

   it "should require an estimated_effort" do
     invalid_deliverable = Deliverable.new(@attr.merge(:estimated_effort => nil))
     invalid_deliverable.should_not be_valid
   end

   it "should require an estimated_effort greater than 0" do
      invalid_deliverable = Deliverable.new(@attr.merge(:estimated_effort => 0))
      invalid_deliverable.should_not be_valid
   end

   it "should require an estimated_size" do
     invalid_deliverable = Deliverable.new(@attr.merge(:estimated_size => nil))
     invalid_deliverable.should_not be_valid
   end

   it "should require an estimated_size greater than 0" do
      invalid_deliverable = Deliverable.new(@attr.merge(:estimated_size => 0))
      invalid_deliverable.should_not be_valid
   end

   it "should require an estimated_production_rate" do
     invalid_deliverable = Deliverable.new(@attr.merge(:estimated_production_rate => nil))
     invalid_deliverable.should_not be_valid
   end

   it "should require an estimated_production_rate greater than 0" do
      invalid_deliverable = Deliverable.new(@attr.merge(:estimated_production_rate => 0))
      invalid_deliverable.should_not be_valid
   end
   
   it "should require a complexity" do
      valid_deliverable = Deliverable.new(@attr.merge(:complexity_id => nil))
      valid_deliverable.should_not be_valid
   end
   
   it "should require that estimated size is equal to estimated effort / estimated production rate" do
     invalid_deliverable = Deliverable.new(@attr.merge(:estimated_size => 9999999))
     invalid_deliverable.should_not be_valid
   end
      
   it "should require that estimated prodcution rate is equal to estimated effort / estimated size" do
     invalid_deliverable = Deliverable.new(@attr.merge(:estimated_production_rate => 9999999))
     invalid_deliverable.should_not be_valid
   end
   
   it "should require that estimated effort is equal to estimated size * estimated production rate" do
     invalid_deliverable = Deliverable.new(@attr.merge(:estimated_effort => 9999999))
     invalid_deliverable.should_not be_valid
   end
   
   it "should calculate the total logged effort" do     
     valid_deliverable = Deliverable.create(@attr)
     effort_log_1 = Factory.create(:effort_log, :deliverable_id => valid_deliverable.id)
     effort_log_2 = Factory.create(:effort_log, :deliverable_id => valid_deliverable.id, :interrupt_time => 30)
     
     valid_deliverable.logged_effort.should == 3.25
   end

end
