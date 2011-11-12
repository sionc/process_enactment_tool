class PagesController < ApplicationController

  def dashboard
    @projects = Project.limit(5)
    @lifecycles = Lifecycle.limit(5)
  end

end
