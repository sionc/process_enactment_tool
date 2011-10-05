require 'spec_helper'

describe "deliverables/show.html.erb" do
  before(:each) do
    @deliverable = assign(:deliverable, stub_model(Deliverable,
      :name => "Name",
      :description => "MyText",
      :estimated_size => 1.5,
      :estimated_production_rate => 1.5,
      :estimated_effort => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end
