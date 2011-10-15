require 'spec_helper'

describe Complexity do
  before(:each) do
    @attr = { :level => "high"}
  end

  it "should create a new record given valid attributes" do
    Complexity.create!(@attr)
  end

  it "should require a level" do
    invalid_complexity = Complexity.new(@attr.merge(:level => nil))
    invalid_complexity.should_not be_valid
  end
end
