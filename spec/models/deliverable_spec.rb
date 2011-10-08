require 'spec_helper'

describe Deliverable do
  before(:each) do
    stock_deliverable_type = Factory.create(:stock_deliverable_type)
    @attr = { :name => "test deliverable",
              :description => "This is the description of the deliverable",
              :estimated_size => 1.5 ,
              :estimated_production_rate => 2.5 ,
              :estimated_effort => 3.5 ,
              :assignable_id => stock_deliverable_type.id,
              :assignable_type => "StockDeliverableType"
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
end
