require 'spec_helper'

describe "deliverables/new.html.erb" do

  before(:each) do
    @stock_deliverable_types = [Factory.create(:stock_deliverable_type)]
    @complexities = [Factory.create(:complexity)]
    @unit = @stock_deliverable_types[0].deliverable_type.unit_of_measure.unit
    assign(:deliverable, stub_model(Deliverable,
      :name => "MyString",
      :description => "MyText",
      :assignable_id => @stock_deliverable_types[0].id,
      :assignable_type => "StockDeliverableType",
      :estimated_size => 1.5,
      :estimated_production_rate => 2.5,
      :estimated_effort => 3.75,
      :complexity_id => @complexities[0].id
    ).as_new_record)
  end

  it "renders new deliverable form" do
   render
  
   assert_select "form", :action => deliverables_path, :method => "post" do
     assert_select "input#deliverable_name", :name => "deliverable[name]"
     assert_select "textarea#deliverable_description", :name => "deliverable[description]"
     assert_select "input#deliverable_estimated_size", :name => "deliverable[estimated_size]"
     assert_select "input#deliverable_estimated_production_rate", :name => "deliverable[estimated_production_rate]"
     assert_select "input#deliverable_estimated_effort", :name => "deliverable[estimated_effort]"
     assert_select "select#deliverable_complexity_id", :name => "deliverable[complexity_id]"
   end

    rendered.should have_selector("p#deliverable_unit_of_measure", :content => "Unit of measure")
  end
  
  it "should have a historical data table" do
    render
  	rendered.should have_xpath("//tr/th[text()='Size']")
  	rendered.should have_xpath("//tr/th[text()='Rate']")
  	rendered.should have_xpath("//tr/th[text()='Effort']")
  	rendered.should have_xpath("//tr/td[text()='Minimum']")
  	rendered.should have_xpath("//tr/td[text()='Average']")
  	rendered.should have_xpath("//tr/td[text()='Maximum']")
	end
  
	it "should have a view historical data link" do
    render
    rendered.should have_xpath("//*[text()='View historical data']")
	end
		    
end
