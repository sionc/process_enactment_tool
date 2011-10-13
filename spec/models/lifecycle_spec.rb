require 'spec_helper'

describe Lifecycle do
  before(:each) do
    @attr = { :name => "test1", :description => "This is the description of the lifecycle"}
  end

  it "should create a new record given valid attributes" do
    Lifecycle.create!(@attr)
  end

  it "should require a name" do
    invalid_lifecycle = Lifecycle.new(@attr.merge(:name => nil))
    invalid_lifecycle.should_not be_valid
  end
end
