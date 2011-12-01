require 'spec_helper'
include Devise::TestHelpers

describe "Deliverables" do

  before(:each) do
    `rake db:seed`
    `rake db:load_demo_data`

    visit user_session_path
    fill_in "Email", :with => "test@test.com"
    fill_in "Password", :with => "testme"
    click_button("Sign in")
  end

  describe "GET new" do

    let(:before_filter) {
      visit projects_path
      click_link 'Gentle Flower'
      page.should have_content("Gentle Flower")
      page.execute_script("$('#project_phases tbody > tr:first').click()")
      page.should have_content("Functional Requirements Document 1")
      sleep(1.5)
      click_link 'New Deliverable'
    }


    describe "(modal)" do
	    it "should pop up modal dialog box when 'NEW' is selected for deliverable type", :js => true do
	      before_filter
	      select('New...', :from => 'deliverable_assignable_id')
	      page.should have_xpath("//*[text()='Create Deliverable Type']", :visible => true)
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

  describe "GET edit" do
     let(:edit_before_filter) {
       visit projects_path
       click_link 'Gentle Flower'
       page.execute_script("$('#project_phases tbody > tr:first').click()")
       click_link 'Functional Requirements Document 1'
       click_link 'Modify'
       page.should have_content("Editing deliverable")
     }

     it "(calculations)", :js => true do
       edit_before_filter

       fill_in "Estimated size", :with => '10'
       page.execute_script("$('#deliverable_estimated_size').trigger('change');")

			 estimated_size = page.evaluate_script("$('#deliverable_estimated_size').val()");
			 estimated_production_rate = page.evaluate_script("$('#deliverable_estimated_production_rate').val()");
			 estimated_effort = estimated_size.to_f * estimated_production_rate.to_f;

       find_field('Estimated effort').value.should == sprintf("%.2f", estimated_effort)
     end
  end

  describe "DELETE destroy" do
    let(:delete_before_filter) {
       visit projects_path
       click_link 'Gentle Flower'
       page.execute_script("$('#project_phases tbody > tr:first').click()")
       click_link 'Functional Requirements Document 1'
       page.evaluate_script('window.confirm = function() { return true; }')
       click_link 'Delete'
     }

    it "should redirect to the project details page", :js => true do
       delete_before_filter
       page.should have_content("Gentle Flower")
       sleep(1.5)
       page.should have_content("Test and Evaluation Master Plan")
    end
  end
end
