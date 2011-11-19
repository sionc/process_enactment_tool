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
       page.should have_xpath("//*[text()='Show historical data']")
       page.should have_xpath("//tr/th[text()='Size']", :visible => false)
       click_link 'Show historical data'
       page.should have_xpath("//*[text()='Hide historical data']")
       page.should have_xpath("//tr/th[text()='Size']", :visible => true)
     end

     it "should disable the view historical data link when a custom deliverable type is selected", :js => true do
       before_filter
       page.should have_xpath("//*[text()='Show historical data']")
       select('New...', :from => 'deliverable_assignable_id')
       fill_in "name", :with => "My new type"
       select('diagrams', :from => 'unit_of_measure_id')
       click_button "Create"
       page.should have_content("No historical data")
       click_link "No historical data"
       page.should have_xpath("//tr/th[text()='Size']", :visible => false)
     end
  end
  
  describe "GET new with set data history" do
    before(:each) do
      `rake db:seed`
      `rake db:seed_test_data`
      
      visit projects_path
      click_link 'Test Gentle Flower'
      page.execute_script("$('#project_phases tbody > tr:first').click()")
      click_link 'New Deliverable'  
      
    end
    
        
    it "should show the historical data", :js => true do
       page.should have_xpath("//*[text()='Show historical data']")
       page.should have_xpath("//tr/th[text()='Size']", :visible => false)
       click_link 'Show historical data'
       page.should have_xpath("//*[text()='Hide historical data']")
       page.should have_xpath("//tr/th[text()='Size']", :visible => true)
       page.should have_xpath("//tr/th[text()='Rate']", :visible => true)
       page.should have_xpath("//tr/th[text()='Effort']", :visible => true)

       page.should have_xpath("//tr/td[text()='Minimum']", :visible => true)
       page.should have_xpath("//tr/td[text()='Average']", :visible => true)
       page.should have_xpath("//tr/td[text()='Maximum']", :visible => true)


       page.should have_xpath("//tr/td[text()='2']", :visible => true)
       page.should have_xpath("//tr/td[text()='6']", :visible => true)
       page.should have_xpath("//tr/td[text()='12']", :visible => true)

       page.should have_xpath("//tr/td[text()='8']", :visible => true)
       page.should have_xpath("//tr/td[text()='24']", :visible => true)
       page.should have_xpath("//tr/td[text()='192']", :visible => true)

       page.should have_xpath("//tr/td[text()='32']", :visible => true)
       page.should have_xpath("//tr/td[text()='96']", :visible => true)
       page.should have_xpath("//tr/td[text()='3072']", :visible => true)

       page.should_not have_xpath("//tr/td[text()='18']", :visible => true)
       page.should_not have_xpath("//tr/td[text()='54']", :visible => true)
       page.should_not have_xpath("//tr/td[text()='972']", :visible => true)
    end
    
    it "should update the historical data table when the deliverable type is changed", :js => true do
       page.should have_xpath("//*[text()='Show historical data']")
       click_link 'Show historical data'
       select('Test and Evaluation Master Plan', :from => 'deliverable_assignable_id')
       sleep(3)
       click_link 'Show historical data'

       page.should have_xpath("//tr/td[text()='2']", :visible => true)
       page.should have_xpath("//tr/td[text()='6']", :visible => true)
       page.should have_xpath("//tr/td[text()='12']", :visible => true)

       page.should have_xpath("//tr/td[text()='8']", :visible => true)
       page.should have_xpath("//tr/td[text()='24']", :visible => true)
       page.should have_xpath("//tr/td[text()='192']", :visible => true)

       page.should have_xpath("//tr/td[text()='32']", :visible => true)
       page.should have_xpath("//tr/td[text()='96']", :visible => true)
       page.should have_xpath("//tr/td[text()='3072']", :visible => true)

       page.should_not have_xpath("//tr/td[text()='18']", :visible => true)
       page.should_not have_xpath("//tr/td[text()='54']", :visible => true)
       page.should_not have_xpath("//tr/td[text()='972']", :visible => true)
    end
    
    it "should update the historical data table when the complexity is changed", :js => true do
      page.should have_xpath("//*[text()='Show historical data']")  
      click_link 'Show historical data'
      select('high', :from => 'deliverable_complexity_id')
      sleep(3)
      click_link 'Show historical data'
      
      page.should have_xpath("//tr/td[text()='2']", :visible => true)
      page.should have_xpath("//tr/td[text()='6']", :visible => true)
      page.should have_xpath("//tr/td[text()='12']", :visible => true)
      
      page.should have_xpath("//tr/td[text()='8']", :visible => true)
      page.should have_xpath("//tr/td[text()='24']", :visible => true)
      page.should have_xpath("//tr/td[text()='192']", :visible => true)
      
      page.should have_xpath("//tr/td[text()='32']", :visible => true)
      page.should have_xpath("//tr/td[text()='96']", :visible => true)
      page.should have_xpath("//tr/td[text()='3072']", :visible => true)
      
      page.should_not have_xpath("//tr/td[text()='18']", :visible => true)
      page.should_not have_xpath("//tr/td[text()='54']", :visible => true)
      page.should_not have_xpath("//tr/td[text()='972']", :visible => true)      
    end  
  end    
  
  
end


