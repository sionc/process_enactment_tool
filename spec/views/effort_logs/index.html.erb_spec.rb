require 'spec_helper'

describe "effort_logs/index.html.erb" do
  before(:each) do
    assign(:effort_logs, [
      stub_model(EffortLog,
        :interrupt_time => 1,
        :comment => "MyText",
        :user_id => 1,
        :deliverable_id => 1
      ),
      stub_model(EffortLog,
        :interrupt_time => 1,
        :comment => "MyText",
        :user_id => 1,
        :deliverable_id => 1
      )
    ])
  end

  it "renders a list of effort_logs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
