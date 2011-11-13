module ProjectsHelper

  # Returns "hours" or "hour" based on the value for Project.estimated_effort
  def get_hours
     if @project.estimated_effort > 1
       "hour".pluralize
     else
       "hour"
     end
  end
end
