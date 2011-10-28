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

    it "should pop up modal dialog box when 'NEW' is selected for deliverable type", :js => true do
      visit projects_path
      click_link 'Gentle Flower'
      page.should have_content("Gentle Flower")
      page.execute_script("$('#project_phases tbody > tr:first').click()")
      page.should have_content("Functional Requirements Document 1")
      click_link 'New Deliverable'
      page.execute_script("$('#deliverable_assignable_id').val('new')")
      #save_and_open_page
    end
  end
end
