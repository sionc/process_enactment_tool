# This is the controller for pages that are not associated with a resource.
# It sets up instance variables that will be used in the views. 

class PagesController < ApplicationController

  # GET /pages/dashboard
  # Controller action for displaying a summary of lifecycles and projects
  def dashboard
    @projects = Project.limit(5)
    @lifecycles = Lifecycle.limit(5)
  end

end