require 'spec_helper'

describe "deliverables/index.html.erb" do
  before(:each) do
    assign(:deliverables, [
      stub_model(Deliverable,
        :name => "Name" ,
        :description => "MyText",
        :estimated_size => 1.5 ,
        :estimated_production_rate => 2.5 ,
        :estimated_effort => 3.75
      ),
      stub_model(Deliverable,
        :name => "Name" ,
        :description => "MyText",
        :estimated_size => 1.5 ,
        :estimated_production_rate => 2.5 ,
        :estimated_effort => 3.75
      )
    ])
  end

  it "renders a list of deliverables" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 3.75.to_s, :count => 2
  end
end
