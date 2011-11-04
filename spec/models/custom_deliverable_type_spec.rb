require 'spec_helper'

describe CustomDeliverableType do
  before(:each) do
     unit_of_measure = Factory.create(:unit_of_measure)
     project_phase = Factory.create(:project_phase)
     @attr = { :name => "My new deliverable type",
               :unit_of_measure_id => unit_of_measure.id,
               :project_phase_id => project_phase.id
     }
   end

   it "should create a new record given valid attributes" do
      CustomDeliverableType.create!(@attr)
    end

   it "should require a name" do
    invalid_custom_del_type = CustomDeliverableType.new(@attr.merge(:name => nil))
    invalid_custom_del_type.should_not be_valid
   end

   it "should require a unit of measure" do
    invalid_custom_del_type = CustomDeliverableType.new(@attr.merge(:unit_of_measure_id => nil))
    invalid_custom_del_type.should_not be_valid
   end

   it "should require a project phase" do
    invalid_custom_del_type = CustomDeliverableType.new(@attr.merge(:project_phase_id => nil))
    invalid_custom_del_type.should_not be_valid
   end
end
