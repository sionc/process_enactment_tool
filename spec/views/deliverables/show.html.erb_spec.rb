require 'spec_helper'

describe "deliverables/show.html.erb" do

  before(:each) do
    @complexities = [Factory.create(:complexity)]
  end
	
  describe "stock deliverable" do
    #     before(:each) do
    #       @stock_deliverable_types = [Factory.create(:stock_deliverable_type)]
    #       assign(:deliverable, stub_model(Deliverable,
    #         :name => "MyString",
    #         :description => "MyText",
    #         :assignable_id => @stock_deliverable_types[0].id,
    #         :assignable_type => "StockDeliverableType",
    #         :estimated_size => 1.5,
    #         :estimated_production_rate => 2.5,
    #         :estimated_effort => 3.5,
    #         :complexity_id => @complexities[0].id
    #       ).as_new_record)
    # end    
		
		before(:each) do
      @stock_deliverable_type = Factory.create(:stock_deliverable_type)
      complexity = Complexity.create(:level => "low")
      @attr = { :name => "MyString",
                :description => "MyText",
                :estimated_effort => 1.5,
                :estimated_size => 2.5,
                :estimated_production_rate => 3.5,
                :complexity_id => complexity.id
              }
       @deliverable = @stock_deliverable_type.deliverables.create! @attr
    end
    
		
		
		
	  it "renders attributes in <p>" do
	    render
	    rendered.should match(/MyString/)
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

    it "renders the complexity" do
	    render
	    rendered.should match(/low/)
	  end
	end
	
  describe "custom deliverable" do
  	before(:each) do
  		@custom_deliverable_type = Factory.create(:custom_deliverable_type)	    
	    
	    complexity = Complexity.create(:level => "low")
      @attr = { :name => "MyString",
                :description => "MyText",
                :estimated_effort => 1.5,
                :estimated_size => 2.5,
                :estimated_production_rate => 3.5,
                :complexity_id => complexity.id
              }
       @deliverable = @custom_deliverable_type.deliverables.create! @attr
      
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
