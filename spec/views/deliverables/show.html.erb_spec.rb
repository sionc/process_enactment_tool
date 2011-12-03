require 'spec_helper'

describe "deliverables/show.html.erb" do

  before(:each) do
    @complexities = [Factory.create(:complexity)]
  end

  describe "stock deliverable" do

    before(:each) do
      @stock_deliverable_type = Factory.create(:stock_deliverable_type)
      complexity = Complexity.create(:level => "low")
      @attr = {:name => "MyString",
               :description => "MyText",
               :estimated_size => 1.5,
               :estimated_production_rate => 2.5,
               :estimated_effort => 3.75,
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
      rendered.should match(/3.75/)
    end

    it "renders the deliverable type" do
      render
      rendered.should match(/Requirements Document/)
    end

    it "renders the unit of measure" do
      render
      rendered.should match(/pages/)
    end

    it "renders the total logged effort" do
      render
      rendered.should match(/Logged effort/)
    end
    
    it "should have a log effort button" do
      render
      rendered.should match(/Log Effort/)
    end

    it "should have a effort log table" do
      render
      rendered.should have_xpath("//tr/th[text()='User email']")
      rendered.should have_xpath("//tr/th[text()='Logged effort (hours)']")
    end

    it "should show Deleted User for user email field in log effort entry for deleted user" do
      @role = Factory.create(:role)
      @user_to_delete = Factory.create(:user, :email => "test@test.com")
      @effort_logs = [Factory.create(:effort_log, :user_id => @user_to_delete.id, :deliverable_id => @deliverable.id)]
      User.delete(@user_to_delete)
      render
      rendered.should match(/Deleted User/)
    end
  end

  describe "custom deliverable" do
    before(:each) do
      @custom_deliverable_type = Factory.create(:custom_deliverable_type)

      complexity = Complexity.create(:level => "low")
      @attr = {:name => "MyString",
               :description => "MyText",
               :estimated_size => 1.5,
               :estimated_production_rate => 2.5,
               :estimated_effort => 3.75,
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
      rendered.should match(/page/)
    end

    it "renders a delete button" do
      render
      rendered.should match(/Delete/)
    end

  end
end
