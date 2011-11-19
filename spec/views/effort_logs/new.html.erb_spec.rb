require 'spec_helper'

describe "effort_logs/new.html.erb" do
  before(:each) do
    @deliverable = Factory.create(:deliverable)
    assign(:effort_log, stub_model(EffortLog,
      :interrupt_time => 1,
      :comment => "MyText",
      :user_id => 1,
      :deliverable_id => @deliverable.id
    ).as_new_record)
  end

  it "renders new effort_log form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => effort_logs_path, :method => "post" do
      assert_select "input#effort_log_interrupt_time", :name => "effort_log[interrupt_time]"
      assert_select "textarea#effort_log_comment", :name => "effort_log[comment]"
    end
  end
end
