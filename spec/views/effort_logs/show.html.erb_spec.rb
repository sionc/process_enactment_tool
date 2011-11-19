require 'spec_helper'

describe "effort_logs/show.html.erb" do
  before(:each) do
    @effort_log = assign(:effort_log, stub_model(EffortLog,
      :interrupt_time => 1,
      :comment => "MyText",
      :user_id => 1,
      :deliverable_id => 1
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
