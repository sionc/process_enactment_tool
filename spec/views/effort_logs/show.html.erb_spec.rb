require 'spec_helper'

describe "effort_logs/show.html.erb" do
  before(:each) do
    @stock_deliverable_type = Factory.create(:stock_deliverable_type)
    complexity = Complexity.create(:level => "low")
    @attr = {:name => "MyString",
             :description => "MyText",
             :estimated_size => 1.5,
             :estimated_production_rate => 2.5,
             :estimated_effort => 3.75,
             :complexity_id => complexity.id
    }
    @deliverable = @stock_deliverable_type.deliverables.create! @attr

    @effort_log = assign(:effort_log, stub_model(EffortLog,
      :interrupt_time => 1,
      :comment => "MyText",
      :user_id => 1,
      :deliverable_id => @deliverable.id
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
