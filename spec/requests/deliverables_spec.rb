require 'spec_helper'

describe "Deliverables" do

  describe "GET /deliverables" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      stock_deliverable_type = Factory.create(:stock_deliverable_type)
      get deliverables_path, :stock_deliverable_type_id => stock_deliverable_type.id
      response.status.should be(200)
    end
  end

  describe "GET new" do
  	before :each do
      `rake db:seed`
      `rake db:load_demo_data`
    end

    let(:before_filter) {
      visit projects_path
      click_link 'Gentle Flower'
      page.should have_content("Gentle Flower")
      page.execute_script("$('#project_phases tbody > tr:first').click()")
      page.should have_content("Functional Requirements Document 1")
      click_link 'New Deliverable'
    }


    describe "(modal)" do
	    it "should pop up modal dialog box when 'NEW' is selected for deliverable type", :js => true do
	      before_filter
	      select('New...', :from => 'deliverable_assignable_id')
	      page.should have_xpath("//*[text()='Create Deliverable Type']", :visible => true)
	      #save_and_open_page
	    end
	    
	    it "should pop up modal dialog box when 'NEW' is selected for deliverable type and have units of measure", :js => true do
	      before_filter
	      select('New...', :from => 'deliverable_assignable_id')
	      page.should have_xpath("//*[text()='Create Deliverable Type']", :visible => true)
	      page.should have_content("pages")
	      page.should have_content("mockups")
	      page.should have_content("use cases")
	      page.should have_content("diagrams")
	      page.should have_content("tests")
	      page.should have_content("lines of code")
	      #save_and_open_page
	    end
	    
	    it "should be able to enter a custom deliverable type name and unit of measure", :js => true do
	      before_filter
	      select('New...', :from => 'deliverable_assignable_id')
	      fill_in "name", :with => "My new type"
	      select('diagrams', :from => 'unit_of_measure_id')
	      click_button "Create"
	      page.should have_xpath(".//option[@selected = 'selected'][text() = 'My new type']")
	    end
		end

		describe "(calculations)" do
	    it "should compute the estimated effort when the size and production rate are entered", :js => true do
	      before_filter
	      
	      fill_in "Estimated size", :with => '23'
	      page.execute_script("$('#deliverable_estimated_size').trigger('change');")
	      
	      fill_in "Estimated production rate", :with => '17'
	      page.execute_script("$('#deliverable_estimated_production_rate').trigger('change');")
	      
	      find_field('Estimated effort').value.should == '391.00'
      end
      
      it "should compute the estimated size when the estimated effort and production rate are entered", :js => true do
	      before_filter
	      
	      fill_in "Estimated effort", :with => '391'
	      page.execute_script("$('#deliverable_estimated_effort').trigger('change');")
	      
	      fill_in "Estimated production rate", :with => '17'
	      page.execute_script("$('#deliverable_estimated_production_rate').trigger('change');")
	      
	      find_field('Estimated size').value.should == '23.00'
      end
      
      it "should compute the estimated production rate when the estimated effort and size are entered", :js => true do
	      before_filter
	      
	      fill_in "Estimated effort", :with => '391'
	      page.execute_script("$('#deliverable_estimated_effort').trigger('change');")
	      
	      fill_in "Estimated size", :with => '23'
	      page.execute_script("$('#deliverable_estimated_size').trigger('change');")
	      
	      find_field('Estimated production rate').value.should == '17.00'
      end
      
      it "should handle a sequence of computations", :js => true do
	      before_filter
	      
	      fill_in "Estimated size", :with => '23'
	      page.execute_script("$('#deliverable_estimated_size').trigger('change');")
	      
	      fill_in "Estimated production rate", :with => '17'
	      page.execute_script("$('#deliverable_estimated_production_rate').trigger('change');")
	      
	      find_field('Estimated effort').value.should == '391.00'
	      
	      fill_in "Estimated size", :with => '46'
	      page.execute_script("$('#deliverable_estimated_size').trigger('change');")
	      
	      find_field('Estimated effort').value.should == '782.00'
	      find_field('Estimated size').value.should == '46' 
      end
            
    end
  end
end
