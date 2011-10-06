require 'spec_helper'

describe Deliverable do
  before(:each) do
    stock_deliverable_type = Factory.create(:stock_deliverable_type)
    @attr = { :name => "test deliverable",
              :description => "This is the description of the deliverable",
              :estimated_size => 1.5 ,
              :estimated_production_rate => 2.5 ,
              :estimated_effort => 3.5 ,
              :project_deliverable_type_id => stock_deliverable_type.id
    }
  end

  it "should create a new record given valid attributes" do
    Deliverable.create!(@attr)
  end

   it "should require a name" do
    invalid_deliverable = Deliverable.new(@attr.merge(:name => nil))
    invalid_deliverable.should_not be_valid
   end

  it "should require a project_deliverable_type_id" do
    invalid_deliverable = Deliverable.new(@attr.merge(:project_deliverable_type_id => nil))
    invalid_deliverable.should_not be_valid
  end

end
