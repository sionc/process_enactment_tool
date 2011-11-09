module ProjectsHelper

  def get_hours
     if @project.estimated_effort > 1
       "hour".pluralize
     else
       "hour"
     end
  end
end
