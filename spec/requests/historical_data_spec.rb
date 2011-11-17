require 'spec_helper'

describe "Deliverable Historical Data" do
  
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
  
    it "should toggle table visibility", :js => true do   
      before_filter
      page.should have_xpath("//*[text()='View historical data']")  
      page.should have_xpath("//tr/th[text()='Size']", :visible => false)
      click_link 'View historical data'
      page.should have_xpath("//*[text()='Hide historical data']")
      page.should have_xpath("//tr/th[text()='Size']", :visible => true)
      
    end
  end
end


