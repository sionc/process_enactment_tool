module DeliverablesHelper

  # Gets the project associated with the deliverable
  def get_project
     @deliverable.assignable.project_phase.project
  end

  # Gets the project phase id string associated with the deliverable
  def get_project_phase_id_string
     @deliverable.assignable.project_phase.id.to_s
  end

end
