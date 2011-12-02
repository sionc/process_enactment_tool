require 'spec_helper'

describe "lifecycle_phases/new.html.erb" do
  before(:each) do
    @lifecycle = Factory.create(:lifecycle)
    assign(:lifecycle_phase, stub_model(LifecyclePhase,
      :name => "MyString",
      :description => "MyText",
      :sequence_number => 1,
      :lifecycle_id => @lifecycle.id
    ).as_new_record)
  end

  it "renders new lifecycle phase form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lifecycle_phases_path, :method => "post" do
      assert_select "input#lifecycle_phase_name", :name => "lifecycle_phase[name]"
      assert_select "textarea#lifecycle_phase_description", :name => "lifecycle_phase[description]"
      assert_select "input#lifecycle_phase_lifecycle_id", :name => "lifecycle_phase[lifecycle_id]"
    end
  end
end
