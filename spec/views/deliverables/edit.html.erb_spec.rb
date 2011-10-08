require 'spec_helper'

describe "deliverables/edit.html.erb" do
  before(:each) do
    @stock_deliverable_type = Factory.create(:stock_deliverable_type)
    @deliverable = assign(:deliverable, stub_model(Deliverable,
      :name => "MyString",
      :description => "MyText",
      :estimated_size => 1.5,
      :estimated_production_rate => 1.5,
      :estimated_effort => 1.5
    ))
  end

  it "renders the edit deliverable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => deliverables_path(@deliverable), :method => "post" do
      assert_select "input#deliverable_name", :name => "deliverable[name]"
      assert_select "textarea#deliverable_description", :name => "deliverable[description]"
      assert_select "input#deliverable_estimated_size", :name => "deliverable[estimated_size]"
      assert_select "input#deliverable_estimated_production_rate", :name => "deliverable[estimated_production_rate]"
      assert_select "input#deliverable_estimated_effort", :name => "deliverable[estimated_effort]"
    end
  end
end
