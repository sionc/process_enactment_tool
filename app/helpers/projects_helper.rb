# Helper class for projects

module ProjectsHelper

  # Returns "hours" or "hour" based on the value for Project.estimated_effort
  def get_hours(field)
     if field > 1
       "hour".pluralize
     else
       "hour"
     end
  end
end
