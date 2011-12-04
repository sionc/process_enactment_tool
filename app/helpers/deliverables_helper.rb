# Helper class for deliverables
module DeliverablesHelper

  # Gets the project associated with the deliverable
  def get_project
     @deliverable.assignable.project_phase.project
  end

  # Gets the project phase id string associated with the deliverable
  def get_project_phase_id_string
     @deliverable.assignable.project_phase.id.to_s
  end

  # Gets the user associated with the effort log
  def get_effort_log_user(effort_log)
    if !effort_log.nil? && !effort_log.user.nil?
      effort_log.user.email
    else
      "Deleted User"
    end
  end

end
