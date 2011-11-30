require 'spec_helper'

describe "effort_logs/show.html.erb" do
  before(:each) do
    @stock_deliverable_type = Factory.create(:stock_deliverable_type)
    complexity = Complexity.create(:level => "low")
    @attr = {:name => "Test deliverable",
             :description => "My description",
             :estimated_size => 1.5,
             :estimated_production_rate => 2.5,
             :estimated_effort => 3.75,
             :complexity_id => complexity.id
    }
    @deliverable = @stock_deliverable_type.deliverables.create! @attr

    @role = Factory.create(:role)
    @user = Factory.create(:user)
    @effort_log = assign(:effort_log, stub_model(EffortLog,
      :interrupt_time => 15,
      :comment => "My comment",
      :user_id => @user.id,
      :deliverable_id => @deliverable.id
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/15/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/My comment/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/test@test.com/)
     # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Test deliverable/)
  end
end
