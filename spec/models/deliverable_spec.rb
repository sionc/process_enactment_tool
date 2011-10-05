require 'spec_helper'

describe Deliverable do
  before(:each) do
    @attr = { :name => "test deliverable",
              :description => "This is the description of the deliverable",
              :estimated_size => 1.5 ,
              :estimated_production_rate => 2.5 ,
              :estimated_effort => 3.5 }
  end

  it "should create a new record given valid attributes" do
    Deliverable.create!(@attr)
  end

   it "should require a name" do
    invalid_deliverable = Deliverable.new(@attr.merge(:name => nil))
    invalid_deliverable.should_not be_valid
   end

end
