require 'spec_helper'

describe UnitOfMeasure do
  before(:each) do
    @attr = { :unit => "pages"}
  end

  it "should create a new record given valid attributes" do
    UnitOfMeasure.create!(@attr)
  end

  it "should require a unit" do
    invalid_unit_of_measure = UnitOfMeasure.new(@attr.merge(:unit => nil))
    invalid_unit_of_measure.should_not be_valid
  end
end
