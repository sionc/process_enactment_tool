require 'spec_helper'

describe "deliverables/show.html.erb" do

  before(:each) do
    @stock_deliverable_types = [Factory.create(:stock_deliverable_type)]
    @complexities = [Factory.create(:complexity)]
    assign(:deliverable, stub_model(Deliverable,
      :name => "MyString",
      :description => "MyText",
      :assignable_id => @stock_deliverable_types[0].id,
      :assignable_type => "StockDeliverableType",
      :estimated_size => 1.5,
      :estimated_production_rate => 2.5,
      :estimated_effort => 3.5,
      :complexity_id => @complexities[0].id
    ).as_new_record)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/1.5/)
    rendered.should match(/2.5/)
    rendered.should match(/3.5/)
  end

  it "renders the deliverable type for stock deliverables" do
    render
    rendered.should match(/Requirements Document/)
  end

end
