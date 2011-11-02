require 'spec_helper'

describe "deliverables/show.html.erb" do

  before(:each) do
    @complexities = [Factory.create(:complexity)]
  end
	
  describe "stock deliverable" do
  	before(:each) do
    	@stock_deliverable_types = [Factory.create(:stock_deliverable_type)]
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
	
	  it "renders the deliverable type" do
	    render
	    rendered.should match(/Requirements Document/)
    end

    it "renders the unit of measure" do
	    render
	    rendered.should match(/pages/)
	  end
	end
	
  describe "custom deliverable" do
  	before(:each) do
  		@custom_deliverable_types = [Factory.create(:custom_deliverable_type)]
    	
	    assign(:deliverable, stub_model(Deliverable,
	      :name => "MyString",
	      :description => "MyText",
	      :assignable_id => @custom_deliverable_types[0].id,
	      :assignable_type => "CustomDeliverableType",
	      :estimated_size => 1.5,
	      :estimated_production_rate => 2.5,
	      :estimated_effort => 3.5,
	      :complexity_id => @complexities[0].id
	    ).as_new_record)
		end
		
		it "renders the deliverable type" do
    	render
    	rendered.should match(/Custom Document/)
    end

    it "renders the unit of measure" do
	    render
	    rendered.should match(/pages/)
	  end
  end
	
end
