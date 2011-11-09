require 'spec_helper'

describe "deliverables/edit.html.erb" do
  before(:each) do
    @complexity = Factory.create(:complexity)
  end

  describe 'stock deliverable' do
    before(:each) do
      @stock_deliverable_type = Factory.create(:stock_deliverable_type)

      @attr = {:name => "My Stock Deliverable",
               :description => "My Description",
               :estimated_effort => 1,
               :estimated_size => 2.5,
               :estimated_production_rate => 2.5,
               :complexity_id => @complexity.id
      }
      @deliverable = @stock_deliverable_type.deliverables.create! @attr
    end

    it "renders the edit deliverable form" do
      render

      # Run the generator again with the --webrat flag if you want to use webrat matchers
      assert_select "form", :action => deliverables_path(@deliverable), :method => "post" do
        assert_select "input#deliverable_name", :name => "deliverable[name]"
        assert_select "textarea#deliverable_description", :name => "deliverable[description]"
        assert_select "input#deliverable_estimated_size", :name => "deliverable[estimated_size]"
        assert_select "input#deliverable_estimated_production_rate", :name => "deliverable[estimated_production_rate]"
        assert_select "input#deliverable_estimated_effort", :name => "deliverable[estimated_effort]"
      end
    end
  end

  describe "custom deliverable" do
    before(:each) do
      @custom_deliverable_type = Factory.create(:custom_deliverable_type)

      @attr = {:name => "My Custom Deliverable",
               :description => "My Description",
               :estimated_effort => 1,
               :estimated_size => 2.5,
               :estimated_production_rate => 2.5,
               :complexity_id => @complexity.id
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
  end

end
