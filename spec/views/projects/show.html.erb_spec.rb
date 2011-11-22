require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @lifecycle = Factory.create(:lifecycle)
    @project = assign(:project, stub_model(Project,
      :name => "Name",
      :description => "MyText",
      :lifecycle_id => @lifecycle.id
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    
    rendered.should match(/Estimated Effort/)
    
    rendered.should match(/Logged Effort/)
    
  end
end
